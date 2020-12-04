Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E612CE6FE
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Dec 2020 05:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgLDES4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 23:18:56 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33353 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgLDES4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 3 Dec 2020 23:18:56 -0500
Received: by mail-pl1-f182.google.com with SMTP id t18so2419686plo.0;
        Thu, 03 Dec 2020 20:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zhmN6zrAZzEBUb+ZCNqtex/5sUlkT9917N2lCZNXu5k=;
        b=jxZqb9/MOqouyxCbLXpb1qU7OfSjdUBFDYQDwo5+uwJ1eHhw8+eY2P3w17gY9rHj8Z
         wfiSycz82I0u70DYk/aIuuPV1XKzkcsamoScxbaxDx4uIQSV79KOdCgnPDuFOKdtwDD3
         Y0qoUxu89mYs1Hd4SW3rJh1/Nj1geg4NNA8wudcc25mo7ooGL9jVPVPCt3NTKmJ1mCVZ
         hcLlA4XWCOmLGtAVMyO5bmj7Tcq8pDZBEUJCSyNbqAPHdLb4qiEomUH19L8ReSmhBp5w
         52OWQwb4NleAiMVWCso+IuFlo3hfLUotHLbbzF1bVzypamFDcWb/utgmiBvyu9igfBHl
         1koA==
X-Gm-Message-State: AOAM530TKFjiEDecC5wpke9dB1SMJrxIWVCDsbDG3+rC2ZNfqkbgixXK
        7Nn62cfFHdYRSPXU6mX6IhQ=
X-Google-Smtp-Source: ABdhPJzJNXgxjvCRE1MZNBD+7RePnQag0q4IJ7hsIBTqdUHkbyzbTaii+PRbSqdWDN7X1jNAJx6TXw==
X-Received: by 2002:a17:902:bb94:b029:d6:edb2:4f41 with SMTP id m20-20020a170902bb94b02900d6edb24f41mr2386748pls.3.1607055489437;
        Thu, 03 Dec 2020 20:18:09 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id c134sm3156406pfc.200.2020.12.03.20.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 20:18:08 -0800 (PST)
Date:   Thu, 3 Dec 2020 20:18:07 -0800
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
Message-ID: <X8m4f2OzrE86vnQz@archbook>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-2-sonals@xilinx.com>
 <X8XMicDtVL5mk9Bp@archbook>
 <BY5PR02MB6068571C3BA40EF6F594D6D1B9F30@BY5PR02MB6068.namprd02.prod.outlook.com>
 <X8ge2gIwY/YCWUrT@archbook>
 <BY5PR02MB60682C1D722CEECF20D457E0B9F20@BY5PR02MB6068.namprd02.prod.outlook.com>
 <X8hrZ+JRZjmrF6rZ@archbook>
 <BY5PR02MB60688E2891D648599B360BC1B9F10@BY5PR02MB6068.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR02MB60688E2891D648599B360BC1B9F10@BY5PR02MB6068.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 04, 2020 at 01:17:37AM +0000, Max Zhen wrote:
> Hi Moritz,
> 
> I manually fixed some line breaks. Not sure why outlook is not doing it properly.
> Let me know if it still looks bad to you.

That might just be outlook :)
> 
> Please see my reply below.
> 
> > 
> > 
> > Max,
> > 
> > On Thu, Dec 03, 2020 at 03:38:26AM +0000, Max Zhen wrote:
> > > [...cut...]
> > >
> > > > > > > +xclbin over the User partition as part of DFX. When a user
> > > > > > > +requests loading of a specific xclbin the xmgmt management
> > > > > > > +driver reads the parent interface UUID specified in the xclbin
> > > > > > > +and matches it with child interface UUID exported by Shell to
> > > > > > > +determine if xclbin is compatible with the Shell. If match fails loading of xclbin is denied.
> > > > > > > +
> > > > > > > +xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl command.
> > > > > > > +When loading xclbin xmgmt driver performs the following operations:
> > > > > > > +
> > > > > > > +1. Sanity check the xclbin contents 2. Isolate the User
> > > > > > > +partition 3. Download the bitstream using the FPGA config engine (ICAP) 4.
> > > > > > > +De-isolate the User partition
> > > > > > Is this modelled as bridges and regions?
> > > > >
> > > > > Alveo drivers as written today do not use fpga bridge and region
> > > > > framework. It seems that if we add support for that framework, it’s
> > > > > possible to receive PR program request from kernel outside of xmgmt driver?
> > > > > Currently, we can’t support this and PR program can only be initiated
> > > > > using XRT’s runtime API in user space.
> > > >
> > > > I'm not 100% sure I understand the concern here, let me reply to what
> > > > I think I understand:
> > > >
> > > > You're worried that if you use FPGA region as interface to accept PR
> > > > requests something else could attempt to reconfigure the region from
> > > > within the kernel using the FPGA Region API?
> > > >
> > > > Assuming I got this right, I don't think this is a big deal. When you
> > > > create the regions you control who gets the references to it.
> > >
> > > Thanks for explaining. Yes, I think you got my point :-).
> > 
> > We can add code to make a region 'static' or 'one-time' or 'fixed'.
> > >
> > > >
> > > > From what I've seen so far Regions seem to be roughly equivalent to
> > > > Partitions, hence my surprise to see a new structure bypassing them.
> > >
> > > I see where the gap is.
> > >
> > > Regions in Linux is very different than "partitions" we have defined in xmgmt. Regions seem to be a software data structure
> > > representing an area on the FPGA that can be reprogrammed. This area is protected by the concept of "bridge" which can be disabled
> > > before program and reenabled after it. And you go through region when you need to reprogram this area.
> > 
> > Your central management driver can create / destroy regions at will. It
> > can keep them in a list, array or tree.
> > 
> > Regions can but don't have to have bridges.
> > 
> > If you need to go through the central driver to reprogram a region,
> > you can use that to figure out which region to program.
> 
> That sounds fine. I can create a region and call into it from xmgmt for
> PR programing. The region will, then, call the xmgmt's fpga manager
> to program it.

It sounds closer than what I'd expect.
> 
> > >
> > > The "partition" is part of the main infrastructure of xmgmt driver, which represents a group of subdev drivers for each individual IP
> > > (HW subcomponents). Basically, xmgmt root driver is parent of several partitions who is, in turn, the parent of several subdev drivers.
> > > The parent manages the life cycle of its children here.
> > 
> > I don't see how this is conceptually different from what DFL does, and
> > they managed to use Regions and Bridges.
> > 
> > If things are missing in the framework, please add them instead of
> > rewriting an entire parallel framework.
> > 
> > >
> > > We do have a partition to represent the group of subdevs/IPs in the reprogrammable area. And we also have partitions
> > > representing other areas which cannot be reprogrammed. So, it is difficult to use "Region" to implement "partition".
> > 
> > You implement your regions callbacks, you can return -EINVAL / -ENOTTY
> > if you want to fail a reprogramming request to a static partion /
> > region.
> > 
> > > From what you have explained, it seems that even if I use region / bridge in xmgmt, we can still keep it private to xmgmt instead of
> > > exposing the interface to outside world, which we can't support anyway? This means that region will be used as an internal data
> > > structure for xmgmt. Since we can't simply replace partition with region, we might as well just use partition throughout the driver,
> > > instead of introducing two data structures and use them both in different places.
> > 
> > Think about your partition as an extension to a region that implements
> > what you need to do for your case of enumerating and reprogramming that
> > particular piece of your chip.
> 
> Yes, we can add region / bridges to represent the PR area and use it in our
> code path for reprogramming the PR area. I think what we will do is to
> instantiate a region instance for the PR area and associate it with the
> FPGA manager in xmgmt for reprogramming it. We can also instantiate
> bridges and map the "ULP gate" subdev driver to it in xmgmt. Thus, we
> could incorporate region and bridge data structures in xmgmt for PR
> reprogramming.

I'd need to take another look, but the ULP gate sounds like a bridge (or
close to it).
 
> This will be a non-trivial change for us. I'd like to confirm that this is what
> you are looking for before we start working on the change. Let us know :-).

I understand. It looks like the right direction. Let's discuss code when
we have code to look at.

It may take a couple of iterations to get it all sorted.

That's normal when you show show up with that much code all at once :)

Cheers,
Moritz
