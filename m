Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC52B6FAC
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 21:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgKQUIk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 15:08:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:49664 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKQUIk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 15:08:40 -0500
IronPort-SDR: RTkj704F6n4eAT2phoiqlv8vcLaTa7bj3Ise68e3HLyJEsDTzgyif2+hcOZh1WPdpTGZK8jleQ
 k9ODKOPUgXMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150272591"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150272591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:08:36 -0800
IronPort-SDR: B0i6OBrUFWhHulOnKhnhbHyUTqWv5/rRXKqw+UVnmWzrQGBwuaWNtn1WFo4Pjt3o5HausMattQ
 hjBgZS4jfkoQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="532351972"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 12:08:33 -0800
Date:   Tue, 17 Nov 2020 12:09:51 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <DM6PR11MB381979D8AEDC1F4EA8B4C2BC85E20@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2011171144310.296481@rhweight-WRK1>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com> <20201117012552.262149-3-matthew.gerlach@linux.intel.com> <DM6PR11MB381979D8AEDC1F4EA8B4C2BC85E20@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 17 Nov 2020, Wu, Hao wrote:

>> Subject: [PATCH 2/2] fpga: dfl: look for vendor specific capability
>>
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
>> @@ -501,6 +501,16 @@ Developer only needs to provide a sub feature
>> driver with matched feature id.
>>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-
>> pr.c)
>>  could be a reference.
>>
>> +Location of DFLs on PCI bus
>
> Location of DFLs on PCI Device

I will update in v2.
>
>> +===========================
>> +The start of the DFL is assumed to be offset 0 of bar 0.
>
> the first DFL

I will make this change in v2.

>
>> +Alternatively, a vendor specific capability structure can be used to
>> +specify the location of one or more DFLs.  Intel has reserved the
>
> I believe this capability is used to specify all DFLs on this the PCI device.

Yes, Yilun noticed this as well.  Documentation will be updated in v2.

>
>> +vendor specific id of 0x43 for this purpose.  The vendor specific
>
> VSEC ID is 0x43.

OK will change in v2.

>
> One more question here is, does it require vendor id to be intel firstly?
> Or other vendors could implement the same one but with a different id?

As implemented, the PCI Vendor is not examined.

>> +data begins with a 4 byte count of the number of DFLs followed 4 byte
>
> vendor specific register

Updated in v2.
>
>> +Offset/BIR fields for each DFL. Bits 2:0 of Offset/BIR field indicates
>> +the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>> +zero.
>>
>>  Open discussion
>>  ===============
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index b1b157b41942..5418e8bf2496 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -27,6 +27,13 @@
>>  #define DRV_VERSION	"0.8"
>>  #define DRV_NAME	"dfl-pci"
>>
>> +#define PCI_VNDR_ID_DFLS 0x43
>
> What about PCI_VSEC_ID_INTEL_DFLS?
>
> Is it possible a different ID chosen by different vendor?

I think another vendor could choose their own ID.

>
>> +
>> +#define PCI_VNDR_DFLS_CNT_OFFSET 8
>> +#define PCI_VNDR_DFLS_RES_OFFSET 0x0c
>
> What about VSEC_DFLS_CNT ?

I will remove _OFFSET in v2.

>
>> +
>> +#define PCI_VND_DFLS_RES_BAR_MASK 0x7
>> +
>>  struct cci_drvdata {
>>  	struct dfl_fpga_cdev *cdev;	/* container device */
>>  };
>> @@ -119,6 +126,82 @@ static int *cci_pci_create_irq_table(struct pci_dev
>> *pcidev, unsigned int nvec)
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
>> +	while ((voff = pci_find_next_ext_capability(pcidev, voff,
>> PCI_EXT_CAP_ID_VNDR))) {
>> +
>> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
>> &vndr_hdr);
>> +
>> +		dev_dbg(&pcidev->dev,
>> +			"vendor-specific capability id 0x%x, rev 0x%x len
>> 0x%x\n",
>> +			PCI_VNDR_HEADER_ID(vndr_hdr),
>> +			PCI_VNDR_HEADER_REV(vndr_hdr),
>> +			PCI_VNDR_HEADER_LEN(vndr_hdr));
>
> Why you need this log?

For debugging.

>
>> +
>> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VNDR_ID_DFLS)
>> +			break;
>> +	}
>> +
>> +	if (!voff) {
>> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
>
> 	"no DFL VSEC found"
>
>> +		return -ENODEV;
>> +	}
>> +
>> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT_OFFSET,
>> &dfl_cnt);
>
> I believe OFFSET can be removed. : )

Yes, _OFFSET to be removed in v2.

>
>> +	dev_info(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
>
> dev_dbg

Yup, v2.
>
>> +	for (i = 0; i < dfl_cnt; i++) {
>> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
>> +				      (i * sizeof(dfl_res));
>> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
>> +
>> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
>> +
>> +		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
>> +
>> +		if (bar >= PCI_STD_NUM_BARS) {
>> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		len = pci_resource_len(pcidev, bar);
>> +
>
> Remove this blank line.
OK, v2.

>
>> +		if (len == 0) {
>> +			dev_err(&pcidev->dev, "%s unmapped bar
>> number %d\n",
>
> Why "unmapped bar"?

How about, "zero length bar"?

>
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		offset = dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
>> +
>
> Remove this blank line.

OK, v2.

>
>> +		if (offset >= len) {
>> +			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
>> +				__func__, offset, len);
>> +			return -EINVAL;
>> +		}
>> +
>> +		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n",
>> __func__, bar, offset);
>
> dev_dbg

v2

>
>> +
>> +		start = pci_resource_start(pcidev, bar) + offset;
>> +		len -= offset;
>> +
>> +		if (!PAGE_ALIGNED(start)) {
>
> Is this a hard requirement? Or offset should be page aligned per VSEC definition?
> Or this is just the requirement from driver point of view. Actually we don't like
> to add rules only in driver, so it's better we have this requirement in VSEC definition
> with proper documentation.

The DFL parsing code ioremaps the memory bounded by start/len.  I thought 
this would require the start to be page aligned.

>
>> +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
>
> unaligned

v2.

>
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
>> @@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct
>> pci_dev *pcidev)
>>  			goto irq_free_exit;
>>  	}
>>
>> -	ret = find_dfl_in_bar0(pcidev, info);
>
> find_dfl or find_dfl_by_default
>
> Actually the original idea is to hardcode the start of the first DFL per device id.
>
>> +	ret = find_dfl_in_cfg(pcidev, info);
>
> find_dfl_by_vsec

Adopting find_dfls_by_vsec and find_dfls_by_default in v2.

>
>> +
>
> Remove blank line.

Done in v2.
>
>> +	if (ret)
>> +		ret = find_dfl_in_bar0(pcidev, info);
>
> I am not sure if find_dfl_by_vsec failed, we still can try to find the first dfl in bar0.
> Most cases it won't work, especially for multiple DFLs case. Just return error directly.
> If someone implements the vsec, it must ensure that vsec contains the correct value,
> no fallback solution. Otherwise it doesn't need to implement such vsec, right?

If no VSEC is found, find_dfls_by_vsec will return -ENODEV.  Will update 
to (ret == -ENODEV) in v2.

>
> Thanks
> Hao
>
>>
>>  	if (ret)
>>  		goto irq_free_exit;
>> --
>> 2.25.2
>
>
