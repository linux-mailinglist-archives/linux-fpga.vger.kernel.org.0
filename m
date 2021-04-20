Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A56366020
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Apr 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhDTTSs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Apr 2021 15:18:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:16620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233518AbhDTTSs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Apr 2021 15:18:48 -0400
IronPort-SDR: bvAkeAD4JFJZmbkGBpFeW82jHuTGe4AYXFOaoCgbEtCnNFx/9y8XeCF1bpdObEVdWCUTnM9/Jp
 lwbXqXfKKLhg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195129066"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195129066"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:18:15 -0700
IronPort-SDR: drlGLZFrdoEFIevNgmLTxduNwhniuyJrRq8375QPKIWws0FRmd6Q9Djx1V+cNoqmCD2Xv99KA1
 Jda7mnIJaQ1g==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427114352"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:18:15 -0700
Date:   Tue, 20 Apr 2021 12:19:42 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        russell.h.weight@intel.com, mdf@kernel.org
Subject: Re: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
In-Reply-To: <3f6f683d-8bd2-6394-e9ae-7cb0d1cd7bdd@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2104201217140.709797@rhweight-WRK1>
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com> <3f6f683d-8bd2-6394-e9ae-7cb0d1cd7bdd@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 20 Apr 2021, Tom Rix wrote:

>
> On 4/20/21 10:27 AM, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> 
>> Gracefully ignore misconfigured port entries encountered in
>> incorrect FPGA images.
>> 
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>   drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index b44523e..660d3b6 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
> Does something similar need to be added to find_dfls_by_vsec ?
>>   	int port_num, bar, i, ret = 0;
>>   	resource_size_t start, len;
>>   	void __iomem *base;
>> +	int bars = 0;
>>   	u32 offset;
>>   	u64 v;
>>   @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev 
>> *pcidev,
>>   	if (dfl_feature_is_fme(base)) {
>>   		start = pci_resource_start(pcidev, 0);
>>   		len = pci_resource_len(pcidev, 0);
>> +		bars |= BIT(0);
>>     		dfl_fpga_enum_info_add_dfl(info, start, len);
>>   @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev 
>> *pcidev,
>>   			 */
>>   			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>>   			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
>> +			if (bars & BIT(bar)) {
>> +				dev_warn(&pcidev->dev, "skipping bad port BAR 
>> %d\n", bar);
>> +				continue;
>> +			}
>> +
>>   			start = pci_resource_start(pcidev, bar) + offset;
>> -			len = pci_resource_len(pcidev, bar) - offset;
>> +			len = pci_resource_len(pcidev, bar);
>> +			if (offset >= len) {
>> +				dev_warn(&pcidev->dev, "bad port offset %u >= 
>> %pa\n",
>> +					 offset, &len);
>
> why %pa,&len for instead of %u,len ?
>
> Tom

Hi Tom,

The variable len is of type resource_size_t, and I am following what it 
says to do in Documentation/core-api/printk-formats.rst:

Physical address types phys_addr_t
----------------------------------

::

         %pa[p]  0x01234567 or 0x0123456789abcdef

For printing a phys_addr_t type (and its derivatives, such as
resource_size_t) which can vary based on build options, regardless of the
width of the CPU data path.

Passed by reference.

Matthew
>
>> +				continue;
>> +			}
>>   +			len -= offset;
>> +			bars |= BIT(bar);
>>   			dfl_fpga_enum_info_add_dfl(info, start, len);
>>   		}
>>   	} else if (dfl_feature_is_port(base)) {
>
>
