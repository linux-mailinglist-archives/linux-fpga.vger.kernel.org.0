Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0351943E4D1
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Oct 2021 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhJ1PTH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Oct 2021 11:19:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:21566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhJ1PTF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 28 Oct 2021 11:19:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="211200924"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="211200924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 08:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="447730645"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2021 08:16:35 -0700
Date:   Thu, 28 Oct 2021 23:09:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Message-ID: <20211028150955.GA207794@yilunxu-OptiPlex-7050>
References: <301850cf-9f34-530b-bd9c-fbe9bf9feee5@intel.com>
 <20211019025356.GC40070@yilunxu-OptiPlex-7050>
 <85d56e4b-5bed-693d-4f76-027173a6e7a0@intel.com>
 <20211020011608.GA145760@yilunxu-OptiPlex-7050>
 <38cfb530-8826-7890-da59-c1dd33b9cc7d@intel.com>
 <DM6PR11MB38198F9B969569FDDD71A1CC85849@DM6PR11MB3819.namprd11.prod.outlook.com>
 <03ff4983-d8a9-6ad7-a655-a8dcde3da360@intel.com>
 <DM6PR11MB38192DC4A39D654F88322D0C85859@DM6PR11MB3819.namprd11.prod.outlook.com>
 <e5fa668d-d32c-2285-1145-b1e9128508ec@intel.com>
 <4664128f-1a08-aed9-ca4f-563b7da62883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664128f-1a08-aed9-ca4f-563b7da62883@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Oct 27, 2021 at 08:34:16AM -0700, Tom Rix wrote:
> 
> On 10/27/21 8:11 AM, Russ Weight wrote:
> > 
> > On 10/26/21 8:29 PM, Wu, Hao wrote:
> > > > > > > The API should not only define what it won't do, but also define what
> > > > > > > it will do. But the "image load" just specifies the top half of the
> > > > > > > process. So I don't think this API would be accepted.
> > > > > > So what is the path forward. It seems like you are saying
> > > > > > that the self-describing files do not fit in the fpga-mgr.
> > > > > > Can we reconsider the FPGA Image Load Framework, which does
> > > > > > not make any assumptions about the contents of the image
> > > > > > files?
> > > > > Why we need such "generic data transfer" interface in FPGA
> > > > > framework?
> > > > Are you referring to the use of self-describing files?
> > > > or the generic nature of this class driver?
> > > Yes, why this is under FPGA framework? Per your description that
> > > it can be used to transfer any data, e.g. BMC images, some device
> > > specific data (self-describing image?). Let's take this as example,
> > > if FPGA device is replaced with ASIC on N3000, do you still want
> > > to use FPGA image load framework to transfer your device specific
> > > data, e.g. BMC images? I really hope that FPGA framework code only
> > > focus on common usage of FPGA.
> > > 
> > > > > we need to handle the common need for FPGA
> > > > > devices only, not all devices, like programming FPGA images.
> > > > > So far we even don't know, what's the hardware response on
> > > > > these self-describing files, how we define it as a common need
> > > > > interface in the framework?
> > > > The class driver does not _need_ to reside in the FPGA
> > > > framework. I sent an inquiry to the maintainer of the
> > > > Firmware update subsystem (and cc'd the kernel mailing list)
> > > > and received no responses. I placed it under the FPGA
> > > > framework only because the first user of the class driver
> > > > is an FPGA driver.
> > > You must have enough justifications why this needs to be included
> > > for everybody not for our own case.
> > How do we justify it when there are currently no other known
> > users? I can go ahead and work up some patches for the firmware
> > subsystem, if we can resolve the other concerns below.
> > 
> > > > > If you just want to reuse the
> > > > > fpga-mgr/framework code for your own purpose, Yes, it seems
> > > > > saving some code for you, but finally it loses flexibility, as it's
> > > > > not possible to extend common framework for your own
> > > > > purpose in the future.
> > > > If I understand correctly, you are saying that it doesn't
> > > > fit well in the FPGA manager, because not all file types
> > > > fit the definition of a firmware update? And future file
> > > > types may not fit in fpga-mgr context?
> > > Let's split the use cases, I think the use case that update a persistent
> > > storage for FPGA image, and later use hardware logic (FPGA loader)
> > > to load it into FPGA. This sounds like a common usage for FPGA
> > > devices, so I think this is why Yilun propose to have this part to be
> > > covered by fpga-mgr. But for other cases in your description, e.g.
> > > BMC images, device specific data, self-describing image and etc,
> > > they are out of scope of FPGA.
> > Self-describing files are not something new to us; _ALL_ of the image
> > files that we send to our FPGA cards, including the N3000 FPGA and BMC
> > images, root-entry hashes, key cancellations, etc. are self-describing
> > files. They always have been.
> > 
> > > Actually I don't fully understand why we need to introduce the
> > > "self-describing image" as a common data transfer interface, if
> > > I remember correctly, for N3000, different sub drivers will own
> > > different hardware sub function blocks, why expose such a new
> > > shared communication channel?
> > There is no change here. The N3000 files are self describing. The
> > secure-update sub-driver of the MAX10 BMC invokes the class driver,
> > funnels image data to the BMC, performs handshakes with the BMC,
> > and ultimately returns status through the class driver. All images
> > that are sent to the FPGA card follow this same path - and it works
> > fine.
> > 
> > To try to split out the purposes of each self-describing file to
> > use different kernel APIs means interfacing multiple class drivers
> > to the same MAX10 sub-driver. I think it also means replicating
> > code.
> 
> Could the split be ?
> 
> add max10 bits mfd/
> 
> move image updating out of the kernel and into an uio driver

I'm afraid an uio driver doesn't help in this case. The image updating
is not an independent device, it may dynamically change other hardwares.
So it is better the image updating driver works as an low level driver
which provides services to other feature drivers.

Thanks,
Yilun

> 
> Tom
> 
> > 
> > - Russ
> > > If "self-describing image" is a
> > > request to one of the sub function block, why not just expose
> > > new interface in such hardware block per modularization? I
> > > have some concern that this new requirement may break
> > > current driver architecture for N3000.
> > > 
> > > Hao
> > > 
> > > > - Russ
> > > > > Thanks
> > > > > Hao
