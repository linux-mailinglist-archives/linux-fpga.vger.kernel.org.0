Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB32C11DB
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Nov 2020 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgKWRXN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 23 Nov 2020 12:23:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:22637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbgKWRXN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 23 Nov 2020 12:23:13 -0500
IronPort-SDR: NBYgyMfzrc0ihXeogAU+FoekYpIwOj9I0EXG4mJiqix9j5euCaHXKN/WgrOrTG4p4Ulhf6/aNz
 23Y7gvVdbqrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="256515929"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="256515929"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:23:13 -0800
IronPort-SDR: Ft4PhTCr/UhN3ogk4bmlUg01kSd9ke6/9PNmhB4WZ/UZT0W7/qCyRplhh0ZQlCSTe9aFbUsQzA
 pwhLNMrDxUWQ==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="546495990"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:23:12 -0800
Date:   Mon, 23 Nov 2020 09:24:24 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Moritz Fischer <mdf@kernel.org>
cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        hao.wu@intel.com, trix@redhat.com, linux-doc@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v2 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <X7m8frDb8I+Q3zbt@archbook>
Message-ID: <alpine.DEB.2.22.394.2011230910400.645786@rhweight-WRK1>
References: <20201118190151.365564-1-matthew.gerlach@linux.intel.com> <20201118190151.365564-3-matthew.gerlach@linux.intel.com> <X7m8frDb8I+Q3zbt@archbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sat, 21 Nov 2020, Moritz Fischer wrote:

> Hi Matthew,
>
> On Wed, Nov 18, 2020 at 11:01:51AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
>> specific capability can be used to specify the start of a
>> number of DFLs.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2: Update documentation for clarity.
>>     Clean up  macro names.
>>     Use GENMASK.
>>     Removed spurious blank lines.
>>     Changed some calls from dev_info to dev_dbg.
>>     Specifically check for VSEC not found, -ENODEV.
>>     Ensure correct pci vendor id.
>>     Remove check for page alignment.
>>     Rename find_dfl_in_cfg to find_dfls_by_vsec.
>>     Initialize target memory of pci_read_config_dword to invalid values before use.
>> ---
>>  Documentation/fpga/dfl.rst | 13 ++++++
>>  drivers/fpga/dfl-pci.c     | 87 +++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 0404fe6ffc74..37016ff35a90 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -501,6 +501,19 @@ Developer only needs to provide a sub feature driver with matched feature id.
>>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>>  could be a reference.
>>
>> +Location of DFLs on PCI Device
>> +===========================
>
> Maybe start with: "There are two ways of locating the DFLs"

This seems to be a reasonable suggestion.  I will update the text.

>> +The start of the first DFL is assumed to be offset 0 of bar 0.
>> +If the first node of the DFL is an FME, then further DFLs
>> +in the port(s) are specified in FME header registers.
>> +Alternatively, a vendor specific capability structure can be used to
>> +specify the location of all the DFLs on the device, providing flexibility
>> +for the type of starting node in the DFL.  Intel has reserved the
>> +VSEC ID of 0x43 for this purpose.  The vendor specific
>> +data begins with a 4 byte vendor specific register for the number of DFLs followed 4 byte
>> +Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
>> +indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>> +zero.
> It's nice to have details, thanks! Nit: This could be a table maybe?

I will look into some sort of table if it looks helpful.

>>
>>  Open discussion
>>  ===============
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index b27fae045536..3a6807e3e10c 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -27,6 +27,14 @@
>>  #define DRV_VERSION	"0.8"
>>  #define DRV_NAME	"dfl-pci"
>>
>> +#define PCI_VSEC_ID_INTEL_DFLS 0x43
>> +
>> +#define PCI_VNDR_DFLS_CNT 8
>> +#define PCI_VNDR_DFLS_RES 0x0c
>> +
>> +#define PCI_VNDR_DFLS_RES_BAR_MASK GENMASK(2, 0)
>> +#define PCI_VNDR_DFLS_RES_OFF_MASK GENMASK(31, 3)
>> +
>>  struct cci_drvdata {
>>  	struct dfl_fpga_cdev *cdev;	/* container device */
>>  };
>> @@ -119,8 +127,80 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>>  	return table;
>>  }
>>
>> +static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
>> +{
>> +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
>> +	int dfl_res_off, i, voff = 0;
>> +	resource_size_t start, len;
>> +
>> +	if (pcidev->vendor != PCI_VENDOR_ID_INTEL)
>> +		return -ENODEV;
>> +
>> +	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
>> +		vndr_hdr = 0;
>> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
> Are there concerns around those failing?

The intent is that failing pci_read_config would be handled by 
initializing the target to an invalid value.

>> +
>> +		dev_dbg(&pcidev->dev,
>> +			"vendor-specific capability id 0x%x, rev 0x%x len 0x%x\n",
>> +			PCI_VNDR_HEADER_ID(vndr_hdr),
>> +			PCI_VNDR_HEADER_REV(vndr_hdr),
>> +			PCI_VNDR_HEADER_LEN(vndr_hdr));
>> +
>> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS)
>> +			break;
>> +	}
>> +
>> +	if (!voff) {
>> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	dfl_cnt = 0;
>> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT, &dfl_cnt);
> I guess this could fall on it's face if you'd read back ~0 ... maybe
> I'm being too paranoid :)

I don't think you are being too paranoid.  I can add a check to make sure 
dfl_res_off never outgrows the size of PCIe config space.

>> +	dev_dbg(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
>> +	for (i = 0; i < dfl_cnt; i++) {
>> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES +
>> +				      (i * sizeof(dfl_res));
>> +		dfl_res = GENMASK(31, 0);
>> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
>> +
>> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
>> +
>> +		bar = dfl_res & PCI_VNDR_DFLS_RES_BAR_MASK;
>> +		if (bar >= PCI_STD_NUM_BARS) {
>> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		len = pci_resource_len(pcidev, bar);
>> +		if (len == 0) {
>> +			dev_err(&pcidev->dev, "%s unmapped bar number %d\n",
>> +				__func__, bar);
>> +			return -EINVAL;
>> +		}
>> +
>> +		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
>> +		if (offset >= len) {
>> +			dev_err(&pcidev->dev, "%s bad offset %u >= %pa\n",
>> +				__func__, offset, &len);
>> +			return -EINVAL;
>> +		}
>> +
>> +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);
>> +
>> +		len -= offset;
>> +
>> +		start = pci_resource_start(pcidev, bar) + offset;
>> +
>> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int find_dfls_by_default(struct pci_dev *pcidev,
>> -				struct dfl_fpga_enum_info *info)
>> +			       struct dfl_fpga_enum_info *info)
>>  {
>>  	resource_size_t start, len;
>>  	int port_num, bar, i;
>> @@ -220,7 +300,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>>  			goto irq_free_exit;
>>  	}
>>
>> -	ret = find_dfls_by_default(pcidev, info);
>> +	ret = find_dfls_by_vsec(pcidev, info);
>> +	if (ret == -ENODEV)
>> +		ret = find_dfls_by_default(pcidev, info);
>> +
>>  	if (ret)
>>  		goto irq_free_exit;
>>
>> --
>> 2.25.2
>>
>
> Thanks,
> Moritz
>
