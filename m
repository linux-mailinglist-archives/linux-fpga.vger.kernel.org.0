Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4E4CDC7E
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Mar 2022 19:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiCDS3d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Mar 2022 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiCDS3c (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 4 Mar 2022 13:29:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF64C79B;
        Fri,  4 Mar 2022 10:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646418524; x=1677954524;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GiSHayaTp3plS/8dF4tiE4fhYopJ+xm/lVEP2Z67CGk=;
  b=EiDoe8kLGaOx5oA41UB+Nx9CHOqFoJm3GqEW2zqpNFMKTXyyfBZithAG
   rV9X8pH+hkntnhMYR3jC6f1OVx1l9LRMlNzDk1MYqiJOVWZZlv1oi2u4z
   urZZtD9mMb9P+We4dR0+BLBoC2ABYbql1uEM3Aj/2m7hYTNYiGO0igXeH
   ql3bgNfT12BuUx7gXbiRSu0mGoFjGdos3ATbGAU+wb4IiK0O7jrSCGHk0
   3opOcnALZXGaGaFaG3KjVw7c2e6FhvFxLPupW/2g/Ah8RmN4NrSuRNV3+
   hdbIijUfgG5sewN/2gbGfB1UCWbZZEVy01ym1pUFQabu0ClhuiypeiRnR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278726905"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="278726905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:28:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="552318052"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:28:43 -0800
Date:   Fri, 4 Mar 2022 10:30:47 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Russ Weight <russell.h.weight@intel.com>
cc:     Tom Rix <trix@redhat.com>, hao.wu@intel.com, yilun.xu@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org, corbet@lwn.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
In-Reply-To: <bc41bc12-0d88-771f-7e78-4e29361fcfd8@intel.com>
Message-ID: <alpine.DEB.2.22.394.2203041021240.3408681@rhweight-WRK1>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com> <20220303003534.3307971-2-matthew.gerlach@linux.intel.com> <6448f21f-7ce1-d9ce-1048-29aca14f9d3d@redhat.com> <bc41bc12-0d88-771f-7e78-4e29361fcfd8@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2071792777-1646418653=:3408681"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2071792777-1646418653=:3408681
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 4 Mar 2022, Russ Weight wrote:

>
>
> On 3/3/22 14:04, Tom Rix wrote:
>>
>> On 3/2/22 4:35 PM, matthew.gerlach@linux.intel.com wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add documentation on identifying FPGA based PCI cards prompted
>>> by discussion on the linux-fpga@vger.kernel.org mailing list.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v2: Introduced in v2.
>>> ---
>>>   Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>>> index ef9eec71f6f3..5fb2ca8e76d7 100644
>>> --- a/Documentation/fpga/dfl.rst
>>> +++ b/Documentation/fpga/dfl.rst
>>> @@ -502,6 +502,26 @@ Developer only needs to provide a sub feature driver with matched feature id.
>>>   FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>>>   could be a reference.
>>>   +PCI Device Identification
>>> +================================
>>> +Since FPGA based PCI cards can be reconfigured to a perform a completely
>>> +new function at runtime, properly identifying such cards and binding the
>>> +correct driver can be challenging. In many use cases, deployed FPGA based
>>> +PCI cards are essentially static and the PCI Product ID and Vendor ID pair
>>> +is sufficient to identify the card.  The DFL framework helps with the
>>> +dynamic case of deployed FPGA cards changing at run time by providing
>>> +more detailed information about card discoverable at runtime.
>>> +
>>> +At one level, the DFL on a PCI card describes the function of the card.
>>> +However, the same DFL could be instantiated on different physical cards.
>>> +Conversely, different DFLs could be instantiated on the same physical card.
>>> +Practical management of a cloud containing a heterogeneous set of such cards
>>> +requires a PCI level of card identification. While the PCI Product ID and
>>> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
>>> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
>>> +Vendor ID values. PCI Vital Product Data (VPD) can also be used for
>>> +more granular information about the board.
>>
>> This describes a bit more of the problem, it should describe it wrt ofs dev id. The introduction of the ofs dev should be explicitly called out as a generic pci id.

The problem I'm describing exists for all FPGA based PCI cards; so I am 
purposely trying to be abstract as much as possible.

>>
>> Why couldn't one of the old pci id's be reused ?

Yes, old pci id's could be reused, and people have done just that.  We 
thought a new PCI ID would minimize confusion with cards that have already 
been deployed.

>>
>> How will the subvendor/subid be enforced ?

Subvendor and Subid are managed just like any other PCI card with or 
without a FPGA.

>>
>> Is the current security manager patchset smart enough to save the board from being bricked when a user doesn't look beyond the pci id ?
>
> Yes - the security manager is invoked based of DFL feature ID and revision, and the functionality is differentiated based on the same information.
>
>>
>> What happens if a board uses this device id but doesn't have a max10 to do the update ?

If a board doesn't have a max10, then there will be no DFH for a max10 in 
the board's DFLs.  Presumeably, the board would need some update process, 
and an approprate DFH would be in that board's DFL.

>>
>> Tom
>>
>>> +
>>>   Location of DFLs on a PCI Device
>>>   ================================
>>>   The original method for finding a DFL on a PCI device assumed the start of the
>>
>
>
--8323328-2071792777-1646418653=:3408681--
