Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674A578AF3
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiGRTdM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 15:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiGRTc1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 15:32:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB030F75;
        Mon, 18 Jul 2022 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658172660; x=1689708660;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9GD02O2B9ScKAzTLfwGvBUVnWGkcx3l26eNn+hm2XuY=;
  b=ihtsLWConpCCQB5Zi6KOd3MkmJ2SLDOatfI3CgIq0AiLJS8NJ7A3LVch
   yKz6oup6BYsVIkp/zyLcWEf5AiA6Jye3QDHPHN6O6epSEPjIumSJJkgJP
   cvY1BM6h0X0b/XiEX4I2e3Gv3aYxaj6FP/+LXZYm6ZtS46RxUXm2MrxQT
   +0WK97cioK0v5fTiMz9g9uTX1E4JXp6URw8tlH8ipJoG4lrHo8QS602xY
   M4Va/k8HmSmzIlF7AUOpeQgb858DBYCjCri3lTpMnuIiHdacdYOP3Fvzw
   qdj/MPCm+RQ8wcoyNw7R4R91QDn5h3oZNZ22itsNniFFHLih1W9GJ8UDa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="266709345"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266709345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:31:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="655424146"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:30:59 -0700
Date:   Mon, 18 Jul 2022 12:30:58 -0700 (PDT)
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
Subject: RE: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
In-Reply-To: <DM6PR11MB3819DEC352F9AE313FE340D9858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2207181228030.3963026@rhweight-WRK1>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com> <20220707150549.265621-2-matthew.gerlach@linux.intel.com> <DM6PR11MB3819DEC352F9AE313FE340D9858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
>> Subject: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
>> documentation
>>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation on identifying FPGA based PCI cards prompted
>> by discussion on the linux-fpga@vger.kernel.org mailing list.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3: Add url to page tracking PCI ID information for DFL based cards.
>>
>> v2: Introduced in v2.
>> ---
>>  Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 15b670926084..5144775b860a 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -507,6 +507,27 @@ ids application.
>>  https://github.com/OPAE/dfl-feature-id
>>
>>
>> +PCI Device Identification
>> +================================
>> +Since FPGA based PCI cards can be reconfigured to a perform a completely
>> +new function at runtime, properly identifying such cards and binding the
>> +correct driver can be challenging. In many use cases, deployed FPGA based
>> +PCI cards are essentially static and the PCI Product ID and Vendor ID pair
>> +is sufficient to identify the card.  The DFL framework helps with the
>> +dynamic case of deployed FPGA cards changing at run time by providing
>> +more detailed information about card discoverable at runtime.
>> +
>> +At one level, the DFL on a PCI card describes the function of the card.
>> +However, the same DFL could be instantiated on different physical cards.
>> +Conversely, different DFLs could be instantiated on the same physical card.
>> +Practical management of a cloud containing a heterogeneous set of such
>> cards
>> +requires a PCI level of card identification. While the PCI Product ID and
>> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
>> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
>> +Vendor ID values. Further PCI Product, Vendor, and Subsystem id tracking
>> +can be found at https://github.com/OPAE/dfl-feature-id/blob/main/dfl-pci-
>> ids.rst.
>
> I feel that we may not really need this in fpga-dfl doc, as this is not describing
> any new method provided by DFL, but just something from PCI standard, right?

I think you are correct that this documentation change is not necessary. 
It was useful as a mechanism for discussion, but it is really just 
something from the PCI standard.

I will not include it in the v4 patch set.

>
> Thanks
> Hao
>
