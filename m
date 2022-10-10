Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9275FA2C5
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Oct 2022 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJJReB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Oct 2022 13:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJJReA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Oct 2022 13:34:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8DA74DFC;
        Mon, 10 Oct 2022 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665423239; x=1696959239;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fdI7AdoT/EczV9CqPPDoXW2AhzdvJXI7YCjk6hGrGUk=;
  b=ivymJJgFQMt3dK777odQbc17h2fgHhjXw1Z7PqftQaNHTurwX+LFHWDs
   i7SFF0fihwoYdYdrmZYK29oGgoWULNZI/Hxct7ZTWufht7f9uMsZ5zP3A
   HZZCPAwvlEuURebDiPPiBBFk8O/UYjkQSQH4Q5l5I1PSMZn031V40UUE+
   iCrYsg/vfzU0HBhgWOphS/UHJeNvgvfN4PWOjBPVFrn5dOKxZtz9BcaHY
   aJQ/2tQSysfgYx8MGLX8I6WWeJTbgFz6BAB42F4joWSTPc6xRZWtAtpD0
   rwanqTOqIRnQRdWsmy5nP4oGeiup9DUWGNUx6AZO4yWfcI2BB/EBCo7Zz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303029044"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="303029044"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 10:33:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="715183062"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="715183062"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 10:33:58 -0700
Date:   Mon, 10 Oct 2022 10:34:16 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <7ad7491d-4d7f-986b-5d9d-1cfdeabe23c5@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210101013520.2404672@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-2-matthew.gerlach@linux.intel.com> <7ad7491d-4d7f-986b-5d9d-1cfdeabe23c5@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-801287403-1665423257=:2404672"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-801287403-1665423257=:2404672
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Wed, 5 Oct 2022, Ilpo Järvinen wrote:

> On Tue, 4 Oct 2022, matthew.gerlach@linux.intel.com wrote:
>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation describing the extensions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3: no change
>>
>> v2: s/GUILD/GUID/
>>     add picture
>> ---
>>  Documentation/fpga/dfl.rst | 49 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 15b670926084..7c786b75b498 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -561,6 +561,55 @@ new DFL feature via UIO direct access, its feature id should be added to the
>>  driver's id_table.
>>
>>
>> +Extending the Device Feature Header - DFHv1
>> +===========================================
>> +The current 8 bytes of the Device Feature Header, hereafter referred to as
>> +to DFHv0, provide very little opportunity for the hardware to describe itself
>> +to software. Version 1 of the Device Feature Header (DFHv1) is being introduced
>> +to provide increased flexibility and extensibility to hardware designs using
>> +Device Feature Lists.  The list below describes some of the goals behind the
>> +changes in DFHv1:
>> +
>> +* Provide a standardized mechanism for features to describe
>> +  parameters/capabilities to software.
>> +* Standardize the use of a GUID for all DFHv1 types.
>> +* Decouple the location of the DFH from the register space of the feature itself.
>> +
>> +Modeled after PCI Capabilities, DFHv1 Parameters provide a mechanism to associate
>> +a list of parameter values to a particular feature.
>> +
>> +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUID standard
>> +across all types.
>> +
>> +With DFHv0, the register map of a given feature is located immediately following
>> +the DFHv0 in the memory space.  With DFHv1, the location of the feature register
>> +map can be specified as an offset to the DFHv1 or as an absolute address.  The DFHv1
>> +structure is shown below:
>
> I think this is not a good place for be some kind of v1 marketing speak
> (that said, I think it's fine to include those goals you have there).

I understand the need to avoid marketing speak here.  I will update to 
just state the facts.

>
> I'd restructure this so that this section only talks about DFHv1 w/o
> any comparing how v1 is better than v0. Don't base the description on
> how things changed from v0 but just describe v1, that is, like v1 is
> already there, not only being introduced to supercede/extend v0.
>
> And then create v0 section after this section which focuses solely on v0.

I agree that separate sections simply describing v0 and v1 would be 
better.  I may describe v0 first since it shares some fields with v1.

>
> -- 
> i.
>
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Address/Offset                            1|  Rel  0|
>> +    +-----------------------------------------------------------------------+
>> +    |63 Size of register set  32|Params 31|30 Group    16|15 Instance      0|
>> +    +-----------------------------------------------------------------------+
>> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data                                     0|
>> +    +-----------------------------------------------------------------------+
>> +
>> +                                  ...
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data                                     0|
>> +    +-----------------------------------------------------------------------+
>> +
>>  Open discussion
>>  ===============
>>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
>>
>
>
--8323328-801287403-1665423257=:2404672--
