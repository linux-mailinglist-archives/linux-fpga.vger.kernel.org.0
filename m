Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9190B293774
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Oct 2020 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392328AbgJTJCf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 05:02:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:58059 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390127AbgJTJCe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 05:02:34 -0400
IronPort-SDR: naTDMBqrJlkJRt1lhQQ3GVFJebEm8IYfm9W0y6pP6g2LtUzeb+VVeSVcEy5lDi6pmCQel27igG
 kuyk21FpUcbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="154962197"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="154962197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 02:02:34 -0700
IronPort-SDR: ay6wyb/IrQE+kw/UrUR7SYpQK/CiKKNmI26I3oqf5dB6TYTV7gvARvn3p73AHH+fZENwpTKNTT
 jN4ZFbmDfJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="358455678"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2020 02:02:32 -0700
Date:   Tue, 20 Oct 2020 16:57:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201020085723.GE16172@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
 <20201020073259.GA3803984@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020073259.GA3803984@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 20, 2020 at 09:32:59AM +0200, Greg KH wrote:
> On Tue, Oct 20, 2020 at 03:11:58PM +0800, Xu Yilun wrote:
> > I think it is normal case that a driver is successfully registered but
> > doesn't match any device because it provides no id_table.
> 
> How is that "normal"?  What would ever cause that driver to be bound to
> a device then?

This patchset adds the driver_override sysfs node, to let userspace
specify which driver (by name matching) to be bound to a device. The
driver "dfl-uio-pdev" doesn't provide an id_table, it could only be
bound to a device whose driver_override is set to "dfl-uio-pdev".

Sorry, this is actually not "normal". Usually dfl drivers with valid id_table
should be used to drive the dfl devices. But we also want to give an option
for userspace to take full control of the device, some IP blocks in FPGA are
written for specific purposes by FPGA user so a userspace driver may
serve them better.

> 
> And you better not say userspace is responsible for it...

Actually it is the userspace's decision which device they want to
access directly ...

I'm not sure if this idea is OK. I see similar implementation for
pci/platform devices.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
