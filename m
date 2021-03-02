Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6F32ABD6
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Mar 2021 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbhCBUoq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Mar 2021 15:44:46 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41753 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574370AbhCBPPf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 2 Mar 2021 10:15:35 -0500
Received: by mail-pl1-f174.google.com with SMTP id d11so12197500plo.8;
        Tue, 02 Mar 2021 07:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uiSdTAX5fGCQWtRj6bGUy+pKt+qEdnwtHvd6uiLQ99g=;
        b=JaxAsjWt8qighC4uUM4w7vJlNN8hu9UHndg2iRylsIiSLPGcN1kCZVWrFhwVsXn/eP
         jpWLKr+XvMXFP2LfcPOIT67qLlCJB16fpemvMikXmbzrb078dvghUxlI/ZpQdbhRgrPF
         4nU0kDZ/gOzikDDeNkzPE8h6tgcRQIwnHGJNBz+fbY9HFlYjXVN9iFOzrIVdfDlEC99X
         2n5z1KuXhvh3Y/cz/qx3YdI4TgFi5+6UZ4WATXLWSU/vVoIXd1BXeOvnisqmvRS7BfiV
         WuMaypGbbBa/E8pFVuG/dvU7EU0xoJMkKnGOtnKqGtPf6X7IZgKIEbo4bCn1zj0r8p19
         QgGQ==
X-Gm-Message-State: AOAM532vWqv71lsyv6Gs97+k+rGpWH3QPJTNKIw0MDeAU0QhhJe5dDIB
        khzHd2fsaJITzhF9HQC4+3M=
X-Google-Smtp-Source: ABdhPJzU3c39I247IewBAHksLi8DflbHJZy5CZGtmnHGh4s7HB5mLxx+SLrm2Xw/IsW8owJzyQ6opw==
X-Received: by 2002:a17:90a:4a0a:: with SMTP id e10mr4640637pjh.112.1614698094479;
        Tue, 02 Mar 2021 07:14:54 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d75sm18639178pfd.20.2021.03.02.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 07:14:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 07:14:52 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
Message-ID: <YD5WbLCdCTBALQiI@epycbox.lan>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
 <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
 <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
 <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
 <55ed0169-085c-9706-3b17-23ea582c43c3@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55ed0169-085c-9706-3b17-23ea582c43c3@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 01, 2021 at 04:25:37PM -0800, Lizhi Hou wrote:
> Hi Tom，
> 
> 
> On 02/28/2021 08:54 AM, Tom Rix wrote:
> > CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> > 
> > 
> > On 2/26/21 1:23 PM, Lizhi Hou wrote:
> > > Hi Tom,
> > > 
> > > 
> > snip
> > 
> > > > I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.
> > > This data structure is shared with other tools. And the structure is well defined with reasonable alignment. It is compatible with all compilers we have tested. So pragma pack is not necessary.
> > You can not have possibly tested all the configurations since the kernel supports many arches and compilers.
> > 
> > If the tested existing alignment is ok, pragma pack should be a noop on your tested configurations.
> > 
> > And help cover the untested configurations.
> Got it. I will add pragma pack(1).

Please do not use pragma pack(), add __packed to the structs in
question.

- Moritz
