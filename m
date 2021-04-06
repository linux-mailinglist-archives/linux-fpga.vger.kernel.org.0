Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE58355848
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhDFPko (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 11:40:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:20852 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhDFPko (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 11:40:44 -0400
IronPort-SDR: 0t4QUhTWtomT8UekP8Yqu7m3lWfWKbf3yfLS39m3kq3ZL/+7MJRmdSTxbqnBipdOtQf/0jlGTw
 Lm1tp8H1n69w==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="173172504"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="173172504"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 08:40:36 -0700
IronPort-SDR: /HFmnbYNjhZx1YxmCSWAUvfud0DDF3sX7LduM5lISPlmbBaLvDEZLmCBL/EhQQGlKFr1ygCfhN
 hS4hd1XmHlyw==
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="414818258"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 08:40:35 -0700
Date:   Tue, 6 Apr 2021 08:42:04 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Moritz Fischer <mdf@kernel.org>
cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, russell.h.weight@linux.intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: pci: add DID for D5005 PAC cards
In-Reply-To: <YGuwDHuxQd01sLQu@epycbox.lan>
Message-ID: <alpine.DEB.2.22.394.2104060841350.208844@rhweight-WRK1>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com> <20210405235301.187542-2-matthew.gerlach@linux.intel.com> <YGuwDHuxQd01sLQu@epycbox.lan>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 5 Apr 2021, Moritz Fischer wrote:

> On Mon, Apr 05, 2021 at 04:52:59PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> This patch adds the approved PCI Express Device IDs for the
>> PF and VF for the card for D5005 PAC cards.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/dfl-pci.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index 04e47e2..b44523e 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -69,14 +69,16 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>  }
>>
>>  /* PCI Device ID */
>> -#define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>> -#define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>> -#define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
>> -#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
>> +#define PCIE_DEVICE_ID_PF_INT_5_X		0xBCBD
>> +#define PCIE_DEVICE_ID_PF_INT_6_X		0xBCC0
>> +#define PCIE_DEVICE_ID_PF_DSC_1_X		0x09C4
>> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000		0x0B30
>> +#define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>>  /* VF Device */
>> -#define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
>> -#define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
>> -#define PCIE_DEVICE_ID_VF_DSC_1_X	0x09C5
>> +#define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>> +#define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>> +#define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>> +#define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
>>
>>  static struct pci_device_id cci_pcie_id_tbl[] = {
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
>> @@ -86,6 +88,8 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005),},
>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>  	{0,}
>>  };
>>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>> --
>> 1.8.3.1
>>
>
> Applied to for-next,
>
> Thanks
>

Thank you for the review.

Matthew
