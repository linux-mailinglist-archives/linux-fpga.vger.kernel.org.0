Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01732CCDF6
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 05:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgLCEhq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 23:37:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36130 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCEhp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Dec 2020 23:37:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id j1so452356pld.3;
        Wed, 02 Dec 2020 20:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZkFWBImXYVf/06L2zXbGZrd4htuxgNLwWV0hIjbGqrE=;
        b=Gn/DRyHM5T88MUqYiwVxMrKgJfrX0Yi3JRppPMWKRFhPqBH6B0T5J5/06eSGRyUTwp
         SppmuMZ09gepwyNREmJa/hIux41GUAkdsYFYhI9tJmMLAu+aRTrDJdZJnQ1tKz5ww3SO
         qIwXXLIAX8AiGDZynl9wXCuXsjWcLrO3zXjfG74v8Oh4wn2f9v2hJpbbTpJ5OZ0fUdeh
         XDZtVs6t4AY0sR8ej5Pi99a7w/6kIU0QNQumVzTaztPoi6sGyhBTEnA5WikC5BQwnwkE
         +B2MQhuFCTpxfXs54aqGRTpb/JguldJudOQeiw0bjnQPZ3EDyWCTnXIC82x7q/swYKcm
         z5Lw==
X-Gm-Message-State: AOAM531H4hKwHYM2ZZG4IcqyZvp63Zzam4HRT2KBjanZNZRxiS5pOl9b
        FLy6u8QoTwl0T91//2ZC508=
X-Google-Smtp-Source: ABdhPJyHrgorY/Su8OggxsIs/HmllUabj91qEPtoCTzzfaZKVF5GB52vH8YkZXOPcHvzpbrVp8Vu7Q==
X-Received: by 2002:a17:902:654f:b029:da:347d:7af3 with SMTP id d15-20020a170902654fb02900da347d7af3mr1495746pln.18.1606970218453;
        Wed, 02 Dec 2020 20:36:58 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id x4sm476946pgg.94.2020.12.02.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 20:36:57 -0800 (PST)
Date:   Wed, 2 Dec 2020 20:36:55 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Max Zhen <maxz@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Sonal Santan <sonals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH Xilinx Alveo 1/8] Documentation: fpga: Add a document
 describing Alveo XRT drivers
Message-ID: <X8hrZ+JRZjmrF6rZ@archbook>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-2-sonals@xilinx.com>
 <X8XMicDtVL5mk9Bp@archbook>
 <BY5PR02MB6068571C3BA40EF6F594D6D1B9F30@BY5PR02MB6068.namprd02.prod.outlook.com>
 <X8ge2gIwY/YCWUrT@archbook>
 <BY5PR02MB60682C1D722CEECF20D457E0B9F20@BY5PR02MB6068.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR02MB60682C1D722CEECF20D457E0B9F20@BY5PR02MB6068.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Max,

On Thu, Dec 03, 2020 at 03:38:26AM +0000, Max Zhen wrote:
> [...cut...]
> 
> > > > > +xclbin over the User partition as part of DFX. When a user 
> > > > > +requests loading of a specific xclbin the xmgmt management 
> > > > > +driver reads the parent interface UUID specified in the xclbin 
> > > > > +and matches it with child interface UUID exported by Shell to 
> > > > > +determine if xclbin is compatible
> > > > with the Shell. If match fails loading of xclbin is denied.
> > > > > +
> > > > > +xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl
> > command.
> > > > > +When loading xclbin xmgmt driver performs the following operations:
> > > > > +
> > > > > +1. Sanity check the xclbin contents 2. Isolate the User 
> > > > > +partition 3. Download the bitstream using the FPGA config engine (ICAP) 4.
> > > > > +De-isolate the User partition
> > > > Is this modelled as bridges and regions?
> > >
> > > Alveo drivers as written today do not use fpga bridge and region
> > framework. It seems that if we add support for that framework, it’s 
> > possible to receive PR program request from kernel outside of xmgmt driver?
> > Currently, we can’t support this and PR program can only be initiated 
> > using XRT’s runtime API in user space.
> > 
> > I'm not 100% sure I understand the concern here, let me reply to what 
> > I think I understand:
> > 
> > You're worried that if you use FPGA region as interface to accept PR 
> > requests something else could attempt to reconfigure the region from 
> > within the kernel using the FPGA Region API?
> > 
> > Assuming I got this right, I don't think this is a big deal. When you 
> > create the regions you control who gets the references to it.
> 
> Thanks for explaining. Yes, I think you got my point :-).

We can add code to make a region 'static' or 'one-time' or 'fixed'.
> 
> > 
> > From what I've seen so far Regions seem to be roughly equivalent to 
> > Partitions, hence my surprise to see a new structure bypassing them.
> 
> I see where the gap is.
> 
> Regions in Linux is very different than "partitions" we have defined in xmgmt. Regions seem to be a software data structure representing an area on the FPGA that can be reprogrammed. This area is protected by the concept of "bridge" which can be disabled before program and reenabled after it. And you go through region when you need to reprogram this area.

Your central management driver can create / destroy regions at will. It
can keep them in a list, array or tree.

Regions can but don't have to have bridges.

If you need to go through the central driver to reprogram a region,
you can use that to figure out which region to program.
> 
> The "partition" is part of the main infrastructure of xmgmt driver, which represents a group of subdev drivers for each individual IP (HW subcomponents). Basically, xmgmt root driver is parent of several partitions who is, in turn, the parent of several subdev drivers. The parent manages the life cycle of its children here.

I don't see how this is conceptually different from what DFL does, and
they managed to use Regions and Bridges.

If things are missing in the framework, please add them instead of
rewriting an entire parallel framework.

> 
> We do have a partition to represent the group of subdevs/IPs in the reprogrammable area. And we also have partitions representing other areas which cannot be reprogrammed. So, it is difficult to use "Region" to implement "partition".

You implement your regions callbacks, you can return -EINVAL / -ENOTTY
if you want to fail a reprogramming request to a static partion /
region.

> From what you have explained, it seems that even if I use region / bridge in xmgmt, we can still keep it private to xmgmt instead of exposing the interface to outside world, which we can't support anyway? This means that region will be used as an internal data structure for xmgmt. Since we can't simply replace partition with region, we might as well just use partition throughout the driver, instead of introducing two data structures and use them both in different places.

Think about your partition as an extension to a region that implements
what you need to do for your case of enumerating and reprogramming that
particular piece of your chip.

> However, if using region/bridge can bring in other benefits, please let us know and we could see if we can also add this to xmgmt.

As maintainer I can say it brings the benefit of looking like existing
infrastructure we have. We can add features to the framework as needed
but blanket replacing the entire thing is always a hard sell.
> 
> > >
> > > Or maybe we have missed some points about the use case for this
> > framework?
> > >
> 
> [...cut...]
> 
> > > > > +-----------------
> > > > > +
> > > > > +As mentioned previously xsabin stores metadata which advertise 
> > > > > +HW
> > > > subsystems present in a partition.
> > > > > +The metadata is stored in device tree format with well defined 
> > > > > +schema. Subsystem instantiations are captured as children of 
> > > > > +``addressable_endpoints`` node. Subsystem nodes have standard
> > > > attributes like ``reg``, ``interrupts`` etc. Additionally the 
> > > > nodes also have PCIe specific attributes:
> > > > > +``pcie_physical_function`` and ``pcie_bar_mapping``. These 
> > > > > +identify which PCIe physical function and which BAR space in 
> > > > > +that physical function the subsystem resides. XRT management 
> > > > > +driver uses this information to bind *platform drivers* to the 
> > > > > +subsystem instantiations. The platform drivers are found in 
> > > > > +**xrt-lib.ko** kernel module defined later. Below is an example 
> > > > > +of device tree for Alveo U50
> > > > > +platform::
> > > >
> > > > I might be missing something, but couldn't you structure the 
> > > > addressable endpoints in a way that encode the physical function 
> > > > as a parent / child relation?
> > >
> > > Alveo driver does not generate the metadata. The metadata is 
> > > formatted
> > and generated by HW tools when the Alveo HW platform is built.
> > 
> > Sure, but you control the tools that generate the metadata :) Your 
> > userland can structure / process it however it wants / needs?
> 
> XRT is a runtime software stack, it is not responsible for generating HW metadata. It is one of the consumers of these data. The shell design is generated by a sophisticated tool framework which is difficult to change.

The Kernel userspace ABI is not going to change once it is merged, which
is why we need to get it right. You can change your userspace code long
time after it is merged into the kernel. The otherway round does not
work.

If you're going to do device-tree you'll need device-tree maintainers to
be ok with your bindings.

> However, we will take this as a feedback for future revision of the tool.
> 
> Thanks,
> Max

Btw: Can you fix your line-breaks :)

- Moritz
