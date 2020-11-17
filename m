Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF782B71F8
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 00:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgKQXJG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 18:09:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:13337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgKQXJG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 18:09:06 -0500
IronPort-SDR: 9O+9NLql69GqWdme8JxtLXrzXc3gDB32eyeWlLvy1zm0ii/o7Q2RzGirBWKDdlrMqtcmLkU/vT
 AlXrtsGLFGFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255740712"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255740712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:09:05 -0800
IronPort-SDR: AwiJnKb6bFs3WhEZ1m4iR6bIkAfWXLxHDMvjbjoZTwJ15fGBT6ZhX81NrO5ZevZHM5xCTpsqB8
 OQRQ0t7LPKOg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544249170"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:09:05 -0800
Date:   Tue, 17 Nov 2020 15:10:15 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, linux-doc@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <53b9cb12-8002-5737-ba8b-7c59687ead5a@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2011171457150.312724@rhweight-WRK1>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com> <20201117012552.262149-3-matthew.gerlach@linux.intel.com> <53b9cb12-8002-5737-ba8b-7c59687ead5a@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 17 Nov 2020, Tom Rix wrote:

>
> On 11/16/20 5:25 PM, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
>> specific capability can be used to specify the start of a
>> number of DFLs.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  Documentation/fpga/dfl.rst | 10 +++++
>>  drivers/fpga/dfl-pci.c     | 88 +++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 0404fe6ffc74..c81ceb1e79e2 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -501,6 +501,16 @@ Developer only needs to provide a sub feature driver with matched feature id.
>>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>>  could be a reference.
>>
>> +Location of DFLs on PCI bus
>> +===========================
>> +The start of the DFL is assumed to be offset 0 of bar 0.
>> +Alternatively, a vendor specific capability structure can be used to
>> +specify the location of one or more DFLs.  Intel has reserved the
>> +vendor specific id of 0x43 for this purpose.  The vendor specific
>> +data begins with a 4 byte count of the number of DFLs followed 4 byte
>> +Offset/BIR fields for each DFL. Bits 2:0 of Offset/BIR field indicates
>> +the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>> +zero.
>>
>
> Does the 'Device Feature List (DFL) Overview' section need to change ?

The 'Device Feature List (DFL) Overview' section does not really mention
the starting location of the DFLs.  I think a section on the discussing
the starting location is enough.

>
> Maybe some more ascii art on location of bar0 vs vendor specific ?

I've added some clarity in v2 which might be enough.

>
>>  Open discussion
>>  ===============
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index b1b157b41942..5418e8bf2496 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -27,6 +27,13 @@
>>  #define DRV_VERSION	"0.8"
> Since basic pci functionality is changing, consider incrementing this version.
>>  #define DRV_NAME	"dfl-pci"
>>
>> +#define PCI_VNDR_ID_DFLS 0x43
>> +
>> +#define PCI_VNDR_DFLS_CNT_OFFSET 8
>> +#define PCI_VNDR_DFLS_RES_OFFSET 0x0c
>> +
>> +#define PCI_VND_DFLS_RES_BAR_MASK 0x7
> Is this missing a R? PCI_VNDR_DFLS_RES_BAR_MASK ?

Good catch!.  Will fix in v2.

>> +
>>  struct cci_drvdata {
>>  	struct dfl_fpga_cdev *cdev;	/* container device */
>>  };
>> @@ -119,6 +126,82 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>>  	return table;
>>  }
>>
>> +static int find_dfl_in_cfg(struct pci_dev *pcidev,
>> +			   struct dfl_fpga_enum_info *info)
>> +{
>> +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
>> +	int dfl_res_off, i, voff = 0;
>> +	resource_size_t start, len;
>> +
>> +	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
>> +
> extra nl
Ok, fix in v2.

>> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
>
> A general problem.
>
> Return of pci_read is not checked, nor are the values ex/ vndr_hdr initialized.

In v2 the variables will be initialized to invalid values that will be 
caught with the existing checks.

>
>> +
>> +		dev_dbg(&pcidev->dev,
>> +			"vendor-specific capability id 0x%x, rev 0x%x len 0x%x\n",
>> +			PCI_VNDR_HEADER_ID(vndr_hdr),
>> +			PCI_VNDR_HEADER_REV(vndr_hdr),
>> +			PCI_VNDR_HEADER_LEN(vndr_hdr));
>> +
>> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VNDR_ID_DFLS)
>> +			break;
>> +	}
>> +
>> +	if (!voff) {
>> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT_OFFSET, &dfl_cnt);
>> +	dev_info(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
>> +	for (i = 0; i < dfl_cnt; i++) {
> Is there a upper limit on the dfl_cnt ? maybe PCI_STD_NUM_BARS ?

Technically, there could be more than one DFL in a bar.  I don't
really know what criteria constitutes an upper limit.

>> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
>> +				      (i * sizeof(dfl_res));
>> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
>> +
>> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
>> +
>> +		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
> an extra nl, fix the similar ones as well.
>> +
>> +		if (bar >= PCI_STD_NUM_BARS) {
>> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		len = pci_resource_len(pcidev, bar);
>> +
>> +		if (len == 0) {
>> +			dev_err(&pcidev->dev, "%s unmapped bar number %d\n",
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		offset = dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
>> +
>> +		if (offset >= len) {
>> +			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
>> +				__func__, offset, len);
>> +			return -EINVAL;
>> +		}
>> +
>> +		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);
>> +
>> +		start = pci_resource_start(pcidev, bar) + offset;
>> +		len -= offset;
>> +
>> +		if (!PAGE_ALIGNED(start)) {
>> +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
>> +				__func__, start);
>> +			return -EINVAL;
>> +		}
>> +
>> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int find_dfl_in_bar0(struct pci_dev *pcidev,
>>  			    struct dfl_fpga_enum_info *info)
>>  {
>> @@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>>  			goto irq_free_exit;
>>  	}
>>
>> -	ret = find_dfl_in_bar0(pcidev, info);
>> +	ret = find_dfl_in_cfg(pcidev, info);
>> +
>> +	if (ret)
>> +		ret = find_dfl_in_bar0(pcidev, info);
>
> Is this really an either/or ?
>
> Could there be a base functionality on bar0 and a skew functionality on vendor bars?

For simplicity I think either or is better.  If skew functionality is in 
vendor bars, why not just use the vendor bars all the time.

>
> If vendor is going to completely override, why not use bar0 ?

I'm not sure I understand the question, but in v2 the legacy DFL search 
will only occur if there is no VSEC found.

>
> Tom
>
>>
>>  	if (ret)
>>  		goto irq_free_exit;
>
>
