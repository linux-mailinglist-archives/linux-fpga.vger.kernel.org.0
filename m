Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217729359A
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Oct 2020 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJTHRM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 03:17:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:53719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgJTHRM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 03:17:12 -0400
IronPort-SDR: i3wJyDXz9VP42skEepGlEdBq/jOfBt5Vc7rvR7MpiPSCU6P53OYVW+opUjWVoG1/20AxGFWxit
 r7sdnXTNLJ5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167287121"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="167287121"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 00:17:11 -0700
IronPort-SDR: DBnv6vGrhQydhBtdhMIpzgRRmcF0NXZvtyxrNAgYhks1DLKHZYzr3g1hG3iBtMbOpCjLxFgpW5
 kjMr4rD/1FTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="320550642"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 00:17:07 -0700
Date:   Tue, 20 Oct 2020 15:11:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201020071158.GC28746@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> >>>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> >>>  {
> >>> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> >>> +	if (!dfl_drv || !dfl_drv->probe)
> >> id_table is still needed for the normal case.
> >>
> >> Instead of removing this check, could you add something like
> >>
> >> || (!dfl_drv->is_override && !dfl_drv->id_table)
> > I don't think it is needed. Seems is_override and !id_table are duplicated
> > conditions for this implementation. And it may make confusing, e.g. could
> > a driver been force matched when is_override is not set?
> >
> > I think we could make it simple, if the dfl driver didn't provide the
> > id_table, normally it could not match any device. I think it could be
> > easily understood by dfl driver developers.
> >
> Then an ASSERT should be added in dfl_bus_match() for id_entry.

I didn't get your idea. What Assertion should be added for id_entry?
BUG_ON(id_entry == NULL)? Then dfl-uio-pdev can't be inserted before
driver_override is set.

I think it is normal case that a driver is successfully registered but
doesn't match any device because it provides no id_table.

Thanks,
Yilun.
