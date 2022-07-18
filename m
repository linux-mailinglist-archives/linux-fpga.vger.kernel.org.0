Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8937578AC7
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiGRT1m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiGRT1l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 15:27:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28E2F67D;
        Mon, 18 Jul 2022 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658172461; x=1689708461;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cpspz5hk0l8D4QudLfxSecBxuf+XXfR+ujpkU/UG7pU=;
  b=BjKAphPDWkVMrLAmzrgV9arRNNTFU+KI3ZMQqR9Wjhb7S9QTPVNmlv0i
   aYTNpEsnLONIZ1fpvYVOVvGJl6j4+x/4Pb8IoTn8gKE8SUEh6S1LgtK/b
   gjay37CS+lraeSOao6W0gxa7ituVIOiDlpPsqXRjjLwPt9uzug2kgmJYU
   lvnNnkXnCYcILdRl4ixoiCzRgdoEo4gOQv0I7Tzf08WOW57DeGTgfVuO3
   wEyY3v1twzjr/16tqruBRhwQxdygYSCImk/+aA/7oGo4Lni/m4QAVBBKS
   18ycWkz4RLmT6xUZheiPEzabc1AcVpOJhtV6hWAlDlCwaZp/lRP0B4M9L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283870310"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="283870310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:27:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="624861676"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:27:40 -0700
Date:   Mon, 18 Jul 2022 12:27:33 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001
 and C6100 cards
In-Reply-To: <DM6PR11MB381961FEAAEC946E46562C83858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2207181226400.3963026@rhweight-WRK1>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com> <20220707150549.265621-3-matthew.gerlach@linux.intel.com> <DM6PR11MB381961FEAAEC946E46562C83858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 18 Jul 2022, Wu, Hao wrote:

>> -----Original Message-----
>> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
>> Sent: Thursday, July 7, 2022 11:06 PM
>> To: Wu, Hao <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>; Weight,
>> Russell H <russell.h.weight@intel.com>; Muddebihal, Basheer Ahmed
>> <basheer.ahmed.muddebihal@intel.com>; trix@redhat.com;
>> mdf@kernel.org; corbet@lwn.net; linux-fpga@vger.kernel.org; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Tianfei
>> <tianfei.zhang@intel.com>
>> Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Subject: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
>> C6100 cards
>>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add pci_dev_table entries supporting the Intel N6000, N6001
>> and C6100 cards to the dfl-pci driver.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>> ---
>> v3: added necessary subdevice ids
>>     removed 'drivers: ' from title
>>
>> v2: changed names from INTEL_OFS to INTEL_DFL
>> ---
>>  drivers/fpga/dfl-pci.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index fd1fa55c9113..94eabdf1d2f7 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -77,12 +77,19 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
>> +#define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
>>
>>  /* VF Device */
>>  #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>>  #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>>  #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
>> +#define PCIE_DEVICE_ID_INTEL_DFL_VF		0xbccf
>> +
>> +/* PCI Subdevice ID */
>> +#define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
>> +#define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
>> +#define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
>
> Please move SUBDEVICE_ID above together with DEVICE_ID.
> If we add new SUBDEVICE to some other device like this, it will
> be hard to distinguish them.

This is a very good suggestion.  I will resubmit with your suggestion.

Thanks for the review.
Matthew
>
> With above change.
> Acked-by: Wu Hao <hao.wu@intel.com>
>
> Thanks
> Hao
>
>
