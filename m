Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E82F0CF4
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 07:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhAKGd2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 01:33:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:40589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbhAKGd2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 01:33:28 -0500
IronPort-SDR: q/vKTc7qEWegSa9Rb4NBFWPNMNsez7fgKolA1jh8fHboMMAJ5BAad6lVm5d5nDoWqeKlsVGRc+
 Wj6mzYzSiEUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157591445"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="157591445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 22:32:47 -0800
IronPort-SDR: UHsN/HkFQIDRuJCmd5OAWm1AizJoHA+z47dtxtwsAdWyiisz+2X3rl2+b5h2FIUGM18L9i2KoI
 DWHwyLq2GCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="498472968"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2021 22:32:44 -0800
Date:   Mon, 11 Jan 2021 14:27:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 0/2] UIO support for dfl devices
Message-ID: <20210111062755.GB13963@yilunxu-OptiPlex-7050>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <X/tcdB0hwDLog1TW@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/tcdB0hwDLog1TW@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jan 10, 2021 at 11:58:44AM -0800, Moritz Fischer wrote:
> Hi Xu,
> 
> On Sat, Jan 02, 2021 at 11:13:00AM +0800, Xu Yilun wrote:
> > This patchset supports some dfl device drivers written in userspace.
> > 
> > In the patchset v1, the "driver_override" interface should be used to bind
> > the DFL UIO driver to DFL devices. But there is concern that the
> > "driver_override" interface is not OK itself.
> > 
> > In v2, we use a new matching algorithem. The "driver_override" interface
> > is abandoned, the DFL UIO driver matches any DFL device which could not be
> > handled by other DFL drivers. So the DFL UIO driver could be used for new
> > DFL devices which are not supported by kernel. The concern is the UIO may
> > not be suitable as a default/generic driver for all dfl features, such as
> > features with multiple interrupts.
> > 
> > In v4, we specify each matching device in the id_table of the UIO driver,
> > just the same as other dfl drivers do. Now the UIO driver supports Ether
> > Group feature. To support more DFL features, their feature ids should be
> > added to the driver's id_table.
> 
> I think this is what you want, yes. Instead of doing a driver override
> or such, add devices that should always be bound to UIO to a device id
> table. For those you temporarily want to bind, make sure you can unbind
> them and use 'new_id' or 'bind' in sysfs, similar to what sysfs does.

"new_id" is not generic to all bus drivers, we need to add the attr in
dfl bus driver like pci do, actually I think quite similar to
"driver_override", How do you think?

I'm glad we restarted the discussion for the temporary binding of UIO
driver.

Thanks,
Yilun
