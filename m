Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02474730EC
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfGXOEr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 10:04:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:24682 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfGXOEr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 10:04:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP; 24 Jul 2019 07:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="345110232"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2019 07:04:44 -0700
Date:   Wed, 24 Jul 2019 21:47:46 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 02/12] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190724134746.GD8463@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-3-git-send-email-hao.wu@intel.com>
 <20190724093357.GA29532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724093357.GA29532@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 24, 2019 at 11:33:57AM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 12:51:25PM +0800, Wu Hao wrote:
> > +/**
> > + * dfl_fpga_cdev_config_port - configure a port feature dev
> > + * @cdev: parent container device.
> > + * @port_id: id of the port feature device.
> > + * @release: release port or assign port back.
> > + *
> > + * This function allows user to release port platform device or assign it back.
> > + * e.g. to safely turn one port from PF into VF for PCI device SRIOV support,
> > + * release port platform device is one necessary step.
> > + */
> > +int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev, int port_id,
> > +			      bool release)
> > +{
> > +	return release ? detach_port_dev(cdev, port_id) :
> > +			 attach_port_dev(cdev, port_id);
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
> 
> That's a horrible api.  Every time you see this call in code, you have
> to go and look up what "bool" means here.  There's no reason for it.
> 
> Just have 2 different functions, one that attaches a port, and one that
> detaches it.  That way when you read the code that calls this function,
> you know what it does instantly without having to go look up some api
> function somewhere else.
> 
> Write code for people to read first.  And you are saving nothing here by
> trying to do two different things in the same exact function.

I see, you're right, it saves everybody's time on reading, very important.
I will fix this and keep it in mind. Thank you.

Hao

> 
> thanks,
> 
> greg k-h
