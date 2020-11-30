Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC742C92FF
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgK3XtE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 18:49:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:61951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388201AbgK3XtE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Nov 2020 18:49:04 -0500
IronPort-SDR: SxSpwoFQURtPYrsd9ZaotauD6Qot2dPi20ciTkxLnM3ew6sL2kfC5UBlcdbq6yT0r/1pOXYflT
 P2y2jBwCND0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="171946554"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="171946554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:47:22 -0800
IronPort-SDR: GskytzeKX1p8N6LHW55ntXI1Uf9QMwaamYRslgzM724dRSsMWgitKUHG5NP38+9F0YZ5ECVdPb
 Ol17LPWpXvPQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364447344"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:47:22 -0800
Date:   Mon, 30 Nov 2020 15:48:29 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 1/2] fpga: dfl: refactor
 cci_enumerate_feature_devs()
In-Reply-To: <DM6PR11MB3819B8E32400D0662CFAD20685F70@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2011301448060.1050045@rhweight-WRK1>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com> <20201124155658.700976-2-matthew.gerlach@linux.intel.com> <DM6PR11MB3819B8E32400D0662CFAD20685F70@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sat, 28 Nov 2020, Wu, Hao wrote:

>> Subject: [PATCH v3 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
>>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> In preparation of looking for dfls based on a vendor
>> specific pcie capability, move code that assumes
>> Bar0/offset0 as start of DFL to its own function.
>
> as the default method to locate the first dfl.
>
How about the following?

In preparation of looking for dfls based on a vendor specific pci 
capability, move the code for the default method of finding the first dfl 
at offset 0 of Bar 0 to its own function.

>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3: no change
>>
>> v2: remove spurious blank lines
>>     rename find_dfl_in_bar0 to find_dfls_by_default
>> ---
>>  drivers/fpga/dfl-pci.c | 84 +++++++++++++++++++++++-------------------
>>  1 file changed, 47 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index a2203d03c9e2..b27fae045536 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev
>> *pcidev, unsigned int nvec)
>>  	return table;
>>  }
>>
>> -/* enumerate feature devices under pci device */
>> -static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>> +static int find_dfls_by_default(struct pci_dev *pcidev,
>> +				struct dfl_fpga_enum_info *info)
>
> Please add one line comment to describe this is the default method
> is finding it in bar 0 and offset 0.
>
>>  {
>> -	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>> -	int port_num, bar, i, nvec, ret = 0;
>> -	struct dfl_fpga_enum_info *info;
>> -	struct dfl_fpga_cdev *cdev;
>>  	resource_size_t start, len;
>> +	int port_num, bar, i;
>>  	void __iomem *base;
>> -	int *irq_table;
>> +	int ret = 0;
>
> can be put into one line as previous code.

Ok, I can fix that.

>
> Other places look good to me.
>
> with above fixings,
> Acked-by: Wu Hao <hao.wu@intel.com>
>
> Thanks
> Hao
>
>>  	u32 offset;
>>  	u64 v;
>>
>> -	/* allocate enumeration info via pci_dev */
>> -	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
>> -	if (!info)
>> -		return -ENOMEM;
>> -
>> -	/* add irq info for enumeration if the device support irq */
>> -	nvec = cci_pci_alloc_irq(pcidev);
>> -	if (nvec < 0) {
>> -		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
>> -		ret = nvec;
>> -		goto enum_info_free_exit;
>> -	} else if (nvec) {
>> -		irq_table = cci_pci_create_irq_table(pcidev, nvec);
>> -		if (!irq_table) {
>> -			ret = -ENOMEM;
>> -			goto irq_free_exit;
>> -		}
>> -
>> -		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
>> -		kfree(irq_table);
>> -		if (ret)
>> -			goto irq_free_exit;
>> -	}
>> -
>> -	/* start to find Device Feature List in Bar 0 */
>> +	/* start to find Device Feature List from Bar 0 */
>>  	base = cci_pci_ioremap_bar0(pcidev);
>> -	if (!base) {
>> -		ret = -ENOMEM;
>> -		goto irq_free_exit;
>> -	}
>> +	if (!base)
>> +		return -ENOMEM;
>>
>>  	/*
>>  	 * PF device has FME and Ports/AFUs, and VF device only has one
>> @@ -208,12 +179,51 @@ static int cci_enumerate_feature_devs(struct
>> pci_dev *pcidev)
>>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>>  	} else {
>>  		ret = -ENODEV;
>> -		goto irq_free_exit;
>>  	}
>>
>>  	/* release I/O mappings for next step enumeration */
>>  	pcim_iounmap_regions(pcidev, BIT(0));
>>
>> +	return ret;
>> +}
>> +
>> +/* enumerate feature devices under pci device */
>> +static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>> +{
>> +	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>> +	struct dfl_fpga_enum_info *info;
>> +	struct dfl_fpga_cdev *cdev;
>> +	int nvec, ret = 0;
>> +	int *irq_table;
>> +
>> +	/* allocate enumeration info via pci_dev */
>> +	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	/* add irq info for enumeration if the device support irq */
>> +	nvec = cci_pci_alloc_irq(pcidev);
>> +	if (nvec < 0) {
>> +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
>> +		ret = nvec;
>> +		goto enum_info_free_exit;
>> +	} else if (nvec) {
>> +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
>> +		if (!irq_table) {
>> +			ret = -ENOMEM;
>> +			goto irq_free_exit;
>> +		}
>> +
>> +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
>> +		kfree(irq_table);
>> +		if (ret)
>> +			goto irq_free_exit;
>> +	}
>> +
>> +	ret = find_dfls_by_default(pcidev, info);
>> +	if (ret)
>> +		goto irq_free_exit;
>> +
>>  	/* start enumeration with prepared enumeration information */
>>  	cdev = dfl_fpga_feature_devs_enumerate(info);
>>  	if (IS_ERR(cdev)) {
>> --
>> 2.25.2
>
>
