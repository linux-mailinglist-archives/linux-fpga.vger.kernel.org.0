Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272AD35FB55
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351203AbhDNTIo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 15:08:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:12463 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346306AbhDNTIn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Apr 2021 15:08:43 -0400
IronPort-SDR: kKFhk/85/RobLfCGWxU3/buJaQBXPdf1pQ3cC5WEP0g/6EM5mqHonGoTxfhwWpFFW+rnupClUt
 T+P3djqovIcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194278294"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194278294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:08:21 -0700
IronPort-SDR: z6Ri1ebOTvWmj4PEWaqchvSi7jLBHlRCzk7MYia5l70Ebpg+H3Jn5ONHVaVpa6hrEkbekUY7PA
 wok4FEiA+01A==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="424867041"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:08:21 -0700
Date:   Wed, 14 Apr 2021 12:09:50 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Mark Brown <broonie@kernel.org>
cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add DFL bus driver for Altera SPI Master
In-Reply-To: <20210414141816.GD4535@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2104141203480.482712@rhweight-WRK1>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com> <20210413225835.459662-2-matthew.gerlach@linux.intel.com> <20210414141816.GD4535@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 14 Apr 2021, Mark Brown wrote:

> On Tue, Apr 13, 2021 at 03:58:34PM -0700, matthew.gerlach@linux.intel.com wrote:
>
>> +++ b/drivers/spi/spi-altera-dfl.c
>> @@ -0,0 +1,222 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DFL bus driver for Altera SPI Master
>> + *
>
> Please make the entire comment a C++ one so things look more
> intentional.

Ok, I'll change it in the next revision.

>
>> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
>> +
>> +	pdevinfo.name = "subdev_spi_altera";
>> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
>> +	pdevinfo.parent = dev;
>> +	pdevinfo.data = &pdata;
>> +	pdevinfo.size_data = sizeof(pdata);
>> +
>> +	return platform_device_register_full(&pdevinfo);
>
> Don't create a platform device here, extend the spi-altera driver to
> register with both DFL and platform buses.
>

Are you suggesting something like the SPI driver for the Designware 
controller where there is spi-dw-core.c and bus specific code like 
spi-dw-pci.c and spi-dw-mmioc.c?

Thanks for the review.

Matthew
