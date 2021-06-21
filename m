Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3113AE526
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUIqa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 04:46:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:8936 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIq3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 04:46:29 -0400
IronPort-SDR: gP0IOFJNtkAObh06AX0GA0BMtToozTMQLDNlpC+qT79DCcy7swQQRTXOIgGeBVJSNs+uS+OyOz
 ry1TiD+HeIMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="206623204"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="206623204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 01:44:10 -0700
IronPort-SDR: fcjoaP9xUrCjzGwX3lAv4N7WaMjcQt+6wZbcHi4InqMLAZfxIDsQBySBZ6XSGEafbWyhd7X9Ab
 HTFWEv3bVBBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486411268"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 01:44:07 -0700
Date:   Mon, 21 Jun 2021 16:38:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
Message-ID: <20210621083856.GA24178@yilunxu-OptiPlex-7050>
References: <20210621070621.431482-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621070621.431482-1-mhu@silicom.dk>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 21, 2021 at 09:06:17AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@geanix.com>
> 
> This is an initial set of patches for the Silciom N5010 programmable
> accelerated card adding support for reading out sensors.

Seems the card is a variant of d5005, just changes the layout of the
sensors in BMC. It may not worth a dedicated PCI DID, and pass
down the info all the way from
  pcie -> dfl -> spi-altera -> m10bmc -> m10bmc-hwmon

Is it possible we just have some version check in m10bmc?

Thank,
Yilun

> 
> I'm not really sure if these should be taken through each of the
> affected trees separately, or just by fpga collectively?
> 
> Based on current master.
> 
> // Martin
> 
> Debarati Biswas (1):
>   fpga: dfl: Move DFH header register macros to linux/dfl.h
> 
> Martin Hundebøll (3):
>   fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
>   spi: spi-altera-dfl: support n5010 feature revision
>   hwmon: intel-m10-bmc: add sensor support for Silicom N5010 card
> 
>  drivers/fpga/dfl-pci.c              |   5 ++
>  drivers/fpga/dfl.h                  |  48 +-----------
>  drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
>  drivers/mfd/intel-m10-bmc.c         |  12 ++-
>  drivers/spi/spi-altera-dfl.c        |  15 +++-
>  include/linux/dfl.h                 |  52 +++++++++++++
>  6 files changed, 198 insertions(+), 50 deletions(-)
> 
> -- 
> 2.31.0
