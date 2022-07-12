Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB2257267C
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Jul 2022 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiGLTrC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Jul 2022 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGLTqV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Jul 2022 15:46:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5129B9D96;
        Tue, 12 Jul 2022 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657654669; x=1689190669;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WsyqKtSXlQhISKt9B4kKgJBG7bo1PNaIJP2Wls34YBY=;
  b=YWDY+uiRyi5v9/62iX9qPH/tkeF9OuLbYwLNK4Y8g/0GHtBe/YxyHgL6
   NlWs5oJUQvZPsoUd7sKCmlIzTMiQX4xqMUhZU9ZOkf7N0CNco/EJ5wP0o
   CcjKTFXXrMyjFToWBpmKoR72OJ2xuEm+xl8CxygXkkkcwdWQrPvS4OmrG
   5wsBSl22EKvkgZ4l7Itu3V0sc7w/VGD8SRnaC2BaU6FWOx7Gvb+NpNoCs
   4/fw4Z6CCfMxOYjeWu9fHSg47uJxKKcglEd0A8cVGRV5/mjNAAlKuyxDU
   zLr0FsFuNSTZuSp0qz5TSRBs0Ipm4ohV8Igu7rGLOJIHbDSX6Es3kfZQZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="282579342"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="282579342"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:37:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="922336550"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:37:48 -0700
Date:   Tue, 12 Jul 2022 12:37:38 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Marco Pagani <marpagan@redhat.com>
cc:     basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001
 and C6100 cards
In-Reply-To: <23a5d310-7d5e-a8ee-bd66-b80505e0553e@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2207121237230.579035@rhweight-WRK1>
References: <20220707150549.265621-3-matthew.gerlach@linux.intel.com> <23a5d310-7d5e-a8ee-bd66-b80505e0553e@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 12 Jul 2022, Marco Pagani wrote:

> On 2022-07-07 17:05, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add pci_dev_table entries supporting the Intel N6000, N6001
>> and C6100 cards to the dfl-pci driver.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>
> Tested-by: Marco Pagani <marpagan@redhat.com>

Thanks for testing.

Matthew
>
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
>>
>>  static struct pci_device_id cci_pcie_id_tbl[] = {
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
>> @@ -96,6 +103,18 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
>> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
>> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
>>  	{0,}
>>  };
>>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>
>
