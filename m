Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20502CCAB4
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 00:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgLBXsc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 18:48:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44080 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgLBXsc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Dec 2020 18:48:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so241190pgi.11;
        Wed, 02 Dec 2020 15:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MCH3F/o+4sEvEJKvPluac3+KmlO3HpjwlsRvnFVoIU=;
        b=qiasvcn/Xz0t8lYrqjrSw6Wc75Ipb2RVCXkd4CopiMaaokYDCt7ENu3CeidV4bUV0d
         riqKXvdTM52V/L3bbG+Eq/XqKw0D4Vew5e+U9+6kjxN2wRuH9q0GfJuBLP+ALJ1vI473
         ymMPZZMS6+6VtMKNwwPs9WjoW2fveI4Q5r9YSiiuBOwaPMz0+l3+Kutu2p9gACwQNvqh
         nCRxo8RHuYFHuWGljdOoIuq3QGfXABJAGpjifloDt0SxojDElTaajiCwYqbHlovoJ/CK
         7Aeuzm7SaoMcWsHIY9K37rv9dlB+XkCQU88ElT0KLjKXcrZeVF8z6c3n+hGWS6bjrhAo
         whNA==
X-Gm-Message-State: AOAM531TpHAfbdr5QHj25doKXxxAb3vdkTrgPfrxiIseKzAoXhhQ6vZr
        QVL5ONLdSZnmsIWFLEKkSCA=
X-Google-Smtp-Source: ABdhPJyx3KArNVsdIOw4tHBfTLGb27SJwLzhjrnOF5thu52tE3FfQmsGN+TJPxEEA3Cx3kmDy2q8WQ==
X-Received: by 2002:a62:293:0:b029:197:96c2:bef6 with SMTP id 141-20020a6202930000b029019796c2bef6mr465584pfc.62.1606952871392;
        Wed, 02 Dec 2020 15:47:51 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id a81sm169015pfd.178.2020.12.02.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:47:50 -0800 (PST)
Date:   Wed, 2 Dec 2020 15:47:49 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Sonal Santan <sonals@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
Message-ID: <X8gnpRgxTeLhBEXd@archbook>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-3-sonals@xilinx.com>
 <X8XGI7yRAX+xAeqQ@archbook>
 <BY5PR02MB6260A727613D2D8A447B1D26BBF30@BY5PR02MB6260.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6260A727613D2D8A447B1D26BBF30@BY5PR02MB6260.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Sonal,

On Wed, Dec 02, 2020 at 06:57:11PM +0000, Sonal Santan wrote:
> Hi Moritz,
> 
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Monday, November 30, 2020 8:27 PM
> > To: Sonal Santan <sonals@xilinx.com>
> > Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen
> > <maxz@xilinx.com>; Lizhi Hou <lizhih@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; Stefano Stabellini <stefanos@xilinx.com>;
> > devicetree@vger.kernel.org
> > Subject: Re: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
> > 
> > Hi Sonal,
> > 
> > On Sat, Nov 28, 2020 at 04:00:34PM -0800, Sonal Santan wrote:
> > > From: Sonal Santan <sonal.santan@xilinx.com>
> > >
> > > Add XRT UAPI header files which describe flash layout, XRT mailbox
> > > protocol, xclBin/axlf FPGA image container format and XRT management
> > > physical function driver ioctl interfaces.
> > >
> > > flash_xrt_data.h:
> > > Layout used by XRT to store private data on flash.
> > >
> > > mailbox_proto.h:
> > > Mailbox opcodes and high level data structures representing various
> > > kinds of information like sensors, clock, etc.
> > >
> > > mailbox_transport.h:
> > > Transport protocol used by mailbox.
> > >
> > > xclbin.h:
> > > Container format used to store compiled FPGA image which includes
> > > bitstream and metadata.
> > 
> > Can these headers be introduced together with the code that uses them as
> > logical change?
> > 
> > I haven't looked too closely, but it helps reviewing if you can break it into
> > smaller pieces that can stand by themselves.
> > 
> 
> These UAPI header files are used by multiple source files hence I wanted to get 
> these reviewed separately. However if this is getting in the way, in the next 
> version of the patch series I would look into arranging the files differently.
> 
> You can browse the changes here as well--
> https://github.com/Xilinx/linux-xoclv2/tree/xrtv2-A

Please submit the code in the form you want the patches to be applied,
in this case submit the headers with the code that uses them, and split
it up in smaller chunks please.

Submitting them as a series in the correct order should provide the
proper context for reviewers.

Cheers,
Moritz
