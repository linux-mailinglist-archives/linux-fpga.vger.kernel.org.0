Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970C3276641
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIXCNB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Sep 2020 22:13:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:2307 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgIXCNB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Sep 2020 22:13:01 -0400
IronPort-SDR: 2X/glouvmea3qXznc/N/pvPkJa8u+eXa2w3Nka5QX6H7m2OcmnGNlM0YwcEywOhDq35VNKVeqS
 3PcDqQJqjW1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="222654903"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="222654903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 19:13:00 -0700
IronPort-SDR: Z8CKOrL+EO0y7jkF0hKOQOUwK2/aQKkkiqjEcSC0HiFfW6HnqiTqplEt3dcy5S+4xZHbl1gimq
 SEYYEqiBTnWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="486702570"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2020 19:12:58 -0700
Date:   Thu, 24 Sep 2020 10:08:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com, yilun.xu@intel.com
Subject: Re: [GIT PULL] FPGA Manager additional changes for 5.10
Message-ID: <20200924020824.GA3288@yilunxu-OptiPlex-7050>
References: <20200921000855.GA15612@epycbox.lan>
 <20200922081339.GA1972786@kroah.com>
 <20200922194908.GA29964@yilunxu-OptiPlex-7050>
 <20200923055436.GA2629915@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923055436.GA2629915@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > 	0006-fpga-dfl-add-support-for-N3000-Nios-private-feature.patch
> > > 		- module parameters are for drivers written in the
> > > 		  1990's.  Please just "do the right thing" and make the
> > > 		  code work properly without having to have custom
> > > 		  options.  Note this option does not really work if you
> > > 		  have multiple devices in the system at once, which is
> > > 		  one reason why we don't use module parameters anymore.
> > 
> > I'm wondering which is the better way to handle the case, but let me
> > first describe it.
> > 
> > The n3000-nios driver will first require the embedded firmware to
> > finish some netdev configuration (via the SPI controller) according to
> > user's option, then the driver takes over the control of the SPI
> > controller and continue to enumerate various devices behind the SPI bus.
> > The firmware will never be active again after the first configuration on
> > power cycle. So I tend to let the driver finish the configuration
> > requirement at probe, then the following drivers for SPI devices could be
> > autoloaded. This is why I choose the module parameter.
> 
> Remember, module parameters affect ALL devices the driver controls, you
> just broke the ability for this driver to handle multiple devices per a
> single driver, with no way of ever fixing that (module parameters are
> userspace apis...)
> 
> > I was considering the sysfs interface option to trigger this one-time
> > configuration. But this makes the SPI devices unavailable until user
> > inputs something to this sysfs node. We may need to add some specific
> > udev rules to make the whole functionalities of the FPGA card enabled
> > automatically.
> 
> Why can't you figure out the state of the device without having to worry
> about a module option?  No one will know how to set that thing, and if
> they do, it will get baked into a bootloader somewhere and no one can
> ever turn it off.

It's the discrete hot-plugable PCIe card which is not managed in host
bootloader. And because of the HW design, the onboard firmware doesn't
get a writable non-volatile memory for the options, so it needs the input
from user.

Anyway, I need to reconsider this solution. But I got learned that "don't
make the user have to configure something out of their scope".

Thanks very much,
Yilun

> 
> Be dynamic and make things "just work" so that the user does not have to
> configure anything at all please.
> 
> > And our customers don't expect different configurations between
> > multiple cards on one system, which also influences my decision.
> 
> They might not say that today, but you just forced them to never be able
> to do that ever, in the next 20+ years :(
> 
> thanks,
> 
> greg k-h
