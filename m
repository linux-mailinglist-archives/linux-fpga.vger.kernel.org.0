Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4364284DC
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Oct 2021 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhJKBuT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Oct 2021 21:50:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:52484 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233414AbhJKBuS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 10 Oct 2021 21:50:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226737948"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226737948"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 18:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="441263696"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2021 18:48:16 -0700
Date:   Mon, 11 Oct 2021 09:41:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Message-ID: <20211011014154.GA82360@yilunxu-OptiPlex-7050>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
 <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
> 
> On 10/9/21 1:08 AM, Xu Yilun wrote:
> > On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
> > > The FPGA Image Load framework provides an API to upload image
> > > files to an FPGA device. Image files are self-describing. They could
> > > contain FPGA images, BMC images, Root Entry Hashes, or other device
> > > specific files. It is up to the lower-level device driver and the
> > > target device to authenticate and disposition the file data.
> > I've reconsider the FPGA persistent image update again, and think we
> > may include it in FPGA manager framework.
> > 
> > Sorry I raised this topic again when it is already at patch v17, but now
> > I need to consider more seriously than before.
> > 
> > We have consensus the FPGA persistent image update is just like a normal
> > firmware update which finally writes the nvmem like flash or eeprom,
> > while the current FPGA manager deals with the active FPGA region update
> > and re-activation. Could we just expand the FPGA manager and let it handle
> > the nvmem update as well? Many FPGA cards have nvmem and downloaders
> > supports updating both FPGA region and nvmem.
> > 
> > According to the patchset, the basic workflow of the 2 update types are
> > quite similar, get the data, prepare for the HW, write and complete.
> > They are already implemented in FPGA manager. We've discussed some
> > differences like threading or canceling the update, which are
> > not provided by FPGA manager but they may also nice to have for FPGA
> > region update. An FPGA region update may also last for a long time??
> > So I think having 2 sets of similar frameworks in FPGA is unnecessary.
> > 
> > My quick mind is that we add some flags in struct fpga_mgr & struct
> > fpga_image_info to indicate the HW capability (support FPGA region
> > update or nvmem update or both) of the download engine and the provided
> > image type. Then the low-level driver knows how to download if it
> > supports both image types.
> > 
> > An char device could be added for each fpga manager dev, providing the
> > user APIs for nvmem update. We may not use the char dev for FPGA region
> > update cause it changes the system HW devices and needs device hotplug
> > in FPGA region. We'd better leave it to FPGA region class, this is
> > another topic.
> > 
> > More discussion is appreciated.
> 
> I also think fpga_mgr could be extended.
> 
> In this patchset,
> 
> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
> 
> A second, similar set of write ops was added to fpga_manger_ops,
> 
> new bit/flag was added to fpga_image_info
> 
> The intent was for dfl to add their specific ops to cover what is done in
> this patchset.

I think we don't have to add 2 ops for reconfig & reimage in framework,
the 2 processes are almost the same.

Just add the _REIMAGE (or something else, NVMEM?) flag for
fpga_image_info, and low level drivers handle it as they do for other
flags.

How do you think?

Thanks,
Yilun

> 
> Any other driver would do similar.
> 
> Is this close to what you are thinking ?
> 
> Tom
> 
> > 
> > Thanks,
> > Yilun
> > 
