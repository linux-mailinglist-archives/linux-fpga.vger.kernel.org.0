Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD183B2542
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 05:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFXDJE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 23:09:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:50860 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhFXDJE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 23:09:04 -0400
IronPort-SDR: NKEkMgnOEX6gyctcOxl4TGnGGDOx6qtiSEty7Qd1xhzuoCxEs0bWUDAE4Td7IfovEUaUAjdRve
 n8i5yev8N1fw==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="204377637"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="204377637"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 20:06:38 -0700
IronPort-SDR: MFTPXEUqxZsu4NobG6Xruu3TraKUQ1MD94yXs+uRuPlLtq+KoQorhUweEgiBnFMZZLvbO8A/tm
 /2bluF/uriBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="423920156"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2021 20:06:34 -0700
Date:   Thu, 24 Jun 2021 11:01:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>
Cc:     "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Message-ID: <20210624030120.GA42039@yilunxu-OptiPlex-7050>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210622052205.GB27046@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819B9B2F357B9B03F7707B685099@DM6PR11MB3819.namprd11.prod.outlook.com>
 <0257dcaf-348a-375d-6ed8-657974208e30@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0257dcaf-348a-375d-6ed8-657974208e30@silicom.dk>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 23, 2021 at 01:56:59PM +0200, Martin Hundebøll wrote:
> 
> 
> On 22/06/2021 09.39, Wu, Hao wrote:
> > > On Mon, Jun 21, 2021 at 06:19:15PM +0800, Wu, Hao wrote:
> > > > > Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
> > > linux/dfl.h
> > > > > 
> > > > > From: Debarati Biswas <debaratix.biswas@intel.com>
> > > > > 
> > > > > Device Feature List (DFL) drivers may be defined in subdirectories other
> > > > > than drivers/fpga, and each DFL driver should have access to the Device
> > > > > Feature Header (DFH) register, which contains revision and type
> > > > > information. This change moves the macros specific to the DFH register
> > > > > from drivers/fpga/dfl.h to include/linux/dfl.h.
> > > > 
> > > > Looks like it requires to access the revision info in the next patch, because
> > > > current dfl_device doesn't expose related information.
> > > > 
> > > > @Yilun, do you have any concern to expose those info via dfl_device?
> > > 
> > > Exposing these header register definitions are good to me. These registers
> > > are in DFL device's MMIO region, so it is good to share these info with
> > > all DFL drivers.
> > 
> > I mean expose revision via dfl_device, as dfl core already reads the DFL
> > header, it sounds duplicate read in each dfl device driver. And if we
> > consider this as a common need from dfl device driver, then the code
> > can be moved to a common place as well.
> > 
> > I hope from dfl device driver side, it doesn't need to know details of
> > how DFH register is defined, only simple way from dfl device data
> > structure or some simple helper function, then dfl device driver could
> > know all common information from DFH.
> > 
> > How do you think?

It's good idea.

> 
> struct dfl_device {} already has "u16 type" and "u16 feature_id", so it would make sense to add "u8 feature_rev" as well?

I think we may name it "u8 revision".

Thanks,
Yilun

> 
> // Martin
