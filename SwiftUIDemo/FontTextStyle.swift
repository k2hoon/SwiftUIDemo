//
//  FontTextStyle.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/07/31.
//

import SwiftUI

struct FontTextStyle: View {
    var body: some View {
        VStack {
            Text("Font TextSytle")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("largeTitle").borderedTextCaption()
                        Text("equal to .font(.system(size: 34, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.largeTitle)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                Group {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 4) {
                            Text("title").borderedTextCaption()
                            Text("equal to .font(.system(size: 28, weight: .regular))")
                                .font(.caption)
                                .underline()
                        }
                        
                        Text("Hello, world")
                            .font(.title)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 4) {
                            Text("title2").borderedTextCaption()
                            Text("equal to .font(.system(size: 22, weight: .regular))")
                                .font(.caption)
                                .underline()
                        }
                        
                        Text("Hello, world")
                            .font(.title2)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 4) {
                            Text("title3").borderedTextCaption()
                            Text("equal to .font(.system(size: 20, weight: .regular))")
                                .font(.caption)
                                .underline()
                        }
                        
                        Text("Hello, world")
                            .font(.title3)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("headline").borderedTextCaption()
                        Text("equal to .font(.system(size: 17, weight: .semibold)")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.headline)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("body").borderedTextCaption()
                        Text("equal to .font(.system(size: 17, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.body)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("callout").borderedTextCaption()
                        Text("equal to .font(.system(size: 16, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.callout)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("subheadline").borderedTextCaption()
                        Text("equal to .font(.system(size: 15, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.subheadline)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("footnote").borderedTextCaption()
                        Text("equal to .font(.system(size: 13, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.footnote)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("caption").borderedTextCaption()
                        Text("equal to .font(.system(size: 12, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.caption)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 4) {
                        Text("caption2").borderedTextCaption()
                        Text("equal to .font(.system(size: 11, weight: .regular))")
                            .font(.caption)
                            .underline()
                    }
                    
                    Text("Hello, world")
                        .font(.caption2)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding()
            }
        }
    }
}

struct FontTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        FontTextStyle()
    }
}
