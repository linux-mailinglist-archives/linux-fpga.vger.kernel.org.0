Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30053670DE
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Apr 2021 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbhDURFx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Apr 2021 13:05:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:16579 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhDURFw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Apr 2021 13:05:52 -0400
IronPort-SDR: Ptxp6wEJA8RHS3LmpK31EePmhjRfrpfzmK5AVcdJQDlSF47Tsc+accAmb64KjZKvh33XHiYbz5
 U+rVQshttRWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216380809"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="216380809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 10:05:18 -0700
IronPort-SDR: 0ue8o3OdCuajNt7TOqgoVSoYxeX9eDPWZ9WcF3WyKlp0d1Wtnkr8OgYGefbshEwYRKC41Vzr4m
 61dRN+4yraJQ==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="602954126"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 10:05:18 -0700
Date:   Wed, 21 Apr 2021 10:06:45 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: RE: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
In-Reply-To: <BYAPR11MB381637F0EFFAFD57902EE47985479@BYAPR11MB3816.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2104211001080.760078@rhweight-WRK1>
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com> <BYAPR11MB381637F0EFFAFD57902EE47985479@BYAPR11MB3816.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 21 Apr 2021, Wu, Hao wrote:

>> Subject: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port entries
>>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Gracefully ignore misconfigured port entries encountered in
>> incorrect FPGA images.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index b44523e..660d3b6 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>>  	int port_num, bar, i, ret = 0;
>>  	resource_size_t start, len;
>>  	void __iomem *base;
>> +	int bars = 0;
>>  	u32 offset;
>>  	u64 v;
>>
>> @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>>  	if (dfl_feature_is_fme(base)) {
>>  		start = pci_resource_start(pcidev, 0);
>>  		len = pci_resource_len(pcidev, 0);
>> +		bars |= BIT(0);
>>
>>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>>
>> @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>>  			 */
>>  			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>>  			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
>> +			if (bars & BIT(bar)) {
>> +				dev_warn(&pcidev->dev, "skipping bad port
>> BAR %d\n", bar);
>> +				continue;
>> +			}
>
> Will it be a real problem that multiple ports are inside one BAR but different offsets?
>
> Hao

I don't think multiple ports within a single BAR is something that has 
been supported in the past.  The genesis for this patch was a 
misconfigured port entry pointing to BAR0.  BAR0 had already been mapped 
for the FME and remapping BAR0 failed resulting in enumeration failure.

Matthew

>
>> +
>>  			start = pci_resource_start(pcidev, bar) + offset;
>> -			len = pci_resource_len(pcidev, bar) - offset;
>> +			len = pci_resource_len(pcidev, bar);
>> +			if (offset >= len) {
>> +				dev_warn(&pcidev->dev, "bad port
>> offset %u >= %pa\n",
>> +					 offset, &len);
>> +				continue;
>> +			}
>>
>> +			len -= offset;
>> +			bars |= BIT(bar);
>>  			dfl_fpga_enum_info_add_dfl(info, start, len);
>>  		}
>>  	} else if (dfl_feature_is_port(base)) {
>> --
>> 1.8.3.1
>
>
