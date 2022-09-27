Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBD5EC300
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Sep 2022 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiI0Min (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Sep 2022 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiI0Mic (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Sep 2022 08:38:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7C14DAE5;
        Tue, 27 Sep 2022 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664282308; x=1695818308;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eQM5lV6ep+EdG9rN9ShbWnoMEO06sNjiz8s3Dt3HjsA=;
  b=iJA11NpopbpUvHdE0mwqgKE3r4aQFcAH3InzhaOr83Qn5Y8cLKfJzgNB
   lUNs4IoETVfVFWKvV4Sah2vGa3Tp2G2iYLkB9kyjdxQjTN3+AvxWowk85
   Jhq5rYWmLqRbWpe3aeLYAlcxEVGJa788aezfr97LjQs1ikPGM2a+dh95I
   f8O+Hwu6e6GvAezamXfeRrGHkemcI0UBsEeFd6OAB8tGQKlAdIzF/oaF1
   Iw3uDRT/jINrp0gjav+ZBN2E3i2eDwNpPJ3U9UW7CVXL0V4LZZWACPWvW
   IE5wm42wBYrywF9Jo0PCxyAGGU6pBqF8g6FModPrGz71hPNE17m22EX17
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288455158"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="288455158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:38:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652263707"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="652263707"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:38:28 -0700
Date:   Tue, 27 Sep 2022 05:38:41 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 1/6] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <40e867ec-c7-66f-9db9-94f6132d587e@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209270535320.2165158@rhweight-WRK1>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-2-matthew.gerlach@linux.intel.com> <40e867ec-c7-66f-9db9-94f6132d587e@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1650586368-1664282327=:2165158"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1650586368-1664282327=:2165158
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 23 Sep 2022, Ilpo Järvinen wrote:

> On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:
>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation describing the extensions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
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
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Address/Offset                            1|  Rel  0|
>> +    +-----------------------------------------------------------------------+
>
> Is something missing here given the layout is claimed (in 2/6) to be:
>
> "DFHv1 Register Offset definitons
> In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA"
>
> ?


I was hesitant to have a picture because the description would then be in 
two places.  I suspect my picture is not clear, but it does line up with 
the offset definitions:

DFH offset 0x0
GUID offsets 0x8 and 0x10
CSR_START offset 0x18
CSR_SIZE offset 0x20
First PARAM_HDR, if it exists, is 0x28,
First PARAM_DATA, if it exists, is 0x30.

>
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
> -- 
> i.
>
>
--8323328-1650586368-1664282327=:2165158--
