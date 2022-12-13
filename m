Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925264BA39
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiLMQuY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 11:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiLMQuV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 11:50:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC6E51;
        Tue, 13 Dec 2022 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670950217; x=1702486217;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q0Bp6JbVuQOPKT7fZaFBaeBR9lMZGHX79ZiOWdxZYyg=;
  b=lXf8XxBLImKgo8I1MnErtq/1BjR8x/U5CKB+P1wsOT8CItyRr7pXwEJf
   h5Rm+L1Mx4PYNuy04HUuXbgFcSBFYNe4CJ8bP396EU7u5wM2ZMkUgcsX7
   VCLyT/f8FjOnJROVy0knoatqyhPzEsK1ljgpOld/ZmgVcE9WKQDOcy/GY
   Tbco4q3vYcvRPQPOCXsglHGUO0r7RpDrAIMEspMEywj91hBgCcfjT99BK
   6mgyDLE682MShjGJM+LxEzOfuAQ2bfhYkfoiXB2n9rQOM8KNVB4VCcGpC
   k/TwNPyDKObBimTo8MtWYmVb8PgPvM9AQATZnXio+Mgh6k26fv7MxfzVZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404438129"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="404438129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 08:50:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681178113"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="681178113"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 08:50:14 -0800
Date:   Tue, 13 Dec 2022 08:50:25 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v6 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <Y5P6NjDxy/S7nlF7@debian.me>
Message-ID: <alpine.DEB.2.22.394.2212130844330.3732069@rhweight-WRK1>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com> <20221209214523.3484193-2-matthew.gerlach@linux.intel.com> <Y5P6NjDxy/S7nlF7@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sat, 10 Dec 2022, Bagas Sanjaya wrote:

> On Fri, Dec 09, 2022 at 01:45:20PM -0800, matthew.gerlach@linux.intel.com wrote:
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 15b670926084..606b4b070c33 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -561,6 +561,109 @@ new DFL feature via UIO direct access, its feature id should be added to the
>>  driver's id_table.
>>
>>
>> +Device Feature Header - Version 0
>> +===========================================
>> +Version 0 (DFHv0) is the original version of the Device Feature Header.
>> +The format of DFHv0 is shown below::
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0| 0x08
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0| 0x10
>> +    +-----------------------------------------------------------------------+
>> +
>> +- Offset 0x00
>> +
>> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +  * DFH VER - The version of the DFH.
>> +  * Rsvd - Currently unused.
>> +  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
>> +  * Next - The offset of the next DFH in the DFL from the start of the DFH. If EOL is set, Next is the size of MMIO ofthe last feature in the list.
>> +  * ID - The ID of the feature if Type is private feature.
>> +
>> +- Offset 0x08
>> +
>> +  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
>> +
>> +- Offset 0x10
>> +
>> +  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
>> +
>> +
>> +Device Feature Header - Version 1
>> +===========================================
>> +Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
>> +
>> +* Provides a standardized mechanism for features to describe parameters/capabilities to software.
>> +* Standardize the use of a GUID for all DFHv1 types.
>> +* Decouples the location of the DFH from the register space of the feature itself.
>> +
>> +The format of Version 1 of the Device Feature Header (DFH) is shown below::
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0| 0x08
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0| 0x10
>> +    +-----------------------------------------------------------------------+
>> +    |63                   Reg Address/Offset                      1|  Rel  0| 0x18
>> +    +-----------------------------------------------------------------------+
>> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
>> +    +-----------------------------------------------------------------------+
>> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data                                     0| 0x30
>> +    +-----------------------------------------------------------------------+
>> +
>> +                                  ...
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0|
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data                                     0|
>> +    +-----------------------------------------------------------------------+
>> +
>> +- Offset 0x00
>> +
>> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +  * DFH VER - The version of the DFH.
>> +  * Rsvd - Currently unused.
>> +  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
>> +  * Next - The offset of the next DFH in the DFL from the start of the DFH.
>> +  * ID - The ID of the feature if Type is private feature.
>> +
>> +- Offset 0x08
>> +
>> +  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
>> +
>> +- Offset 0x10
>> +
>> +  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier.
>> +
>> +- Offset 0x18
>> +
>> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits of a 16 bit aligned absolute address of the feature's registers. If Rel bit is clear, then the value is the offset from the start of the DFH of the feature's registers.
>> +
>> +- Offset 0x20
>> +
>> +  * Reg Size - Size of feature's register set in bytes.
>> +  * Params - Set if DFH has a list of parameter blocks.
>> +  * Group - Id of group if feature is part of a group.
>> +  * Instance - Id of instance of feature within a group.
>> +
>> +- Offset 0x28 if feature has parameters
>> +
>> +  * Next - Offset to the next parameter block in 8 byte words. If EOP set, size in 8 byte words of last parameter.
>> +  * Param Version - Version of Param ID.
>> +  * Param ID - ID of parameter.
>> +
>> +- Offset 0x30
>> +
>> +  * Parameter Data - Parameter data whose size and format is defined by version and ID of the parameter.
>> +
>>  Open discussion
>>  ===============
>>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
>
> What about this wording below (including fitting the prose within 80 columns)?

The wording you suggest is an improvement. I will include your 
suggestions.  I mistakenly thought that Restructured Text needed list 
items to be a single line and checkpatch.pl did not flag the long lines.

Thanks,
Matthew Gerlach

>
> ---- >8 ----
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 606b4b070c3321..3d8f8dde6021db 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -579,26 +579,30 @@ The format of DFHv0 is shown below::
>   * Type - The type of DFH (e.g. FME, AFU, or private feature).
>   * DFH VER - The version of the DFH.
>   * Rsvd - Currently unused.
> -  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
> -  * Next - The offset of the next DFH in the DFL from the start of the DFH. If EOL is set, Next is the size of MMIO ofthe last feature in the list.
> -  * ID - The ID of the feature if Type is private feature.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the DFH start. If EOL is
> +    set, Next is the size of MMIO of the last feature in the list.
> +  * ID - The feature ID if Type is private feature.
>
> - Offset 0x08
>
> -  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
>
> - Offset 0x10
>
> -  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
>
>
> Device Feature Header - Version 1
> ===========================================
> Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
>
> -* Provides a standardized mechanism for features to describe parameters/capabilities to software.
> +* Provides a standardized mechanism for features to describe
> +  parameters/capabilities to software.
> * Standardize the use of a GUID for all DFHv1 types.
> -* Decouples the location of the DFH from the register space of the feature itself.
> +* Decouples the DFH location from the register space of the feature itself.
>
> The format of Version 1 of the Device Feature Header (DFH) is shown below::
>
> @@ -631,38 +635,43 @@ The format of Version 1 of the Device Feature Header (DFH) is shown below::
>   * Type - The type of DFH (e.g. FME, AFU, or private feature).
>   * DFH VER - The version of the DFH.
>   * Rsvd - Currently unused.
> -  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
> -  * Next - The offset of the next DFH in the DFL from the start of the DFH.
> -  * ID - The ID of the feature if Type is private feature.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the DFH start.
> +  * ID - The feature ID if Type is private feature.
>
> - Offset 0x08
>
> -  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier.
>
> - Offset 0x10
>
> -  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier.
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier.
>
> - Offset 0x18
>
> -  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits of a 16 bit aligned absolute address of the feature's registers. If Rel bit is clear, then the value is the offset from the start of the DFH of the feature's registers.
> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits
> +    of a 16-bit aligned absolute address of the feature's registers. Otherwise
> +    the value is the offset from the start of the DFH of the feature's
> +    registers.
>
> - Offset 0x20
>
>   * Reg Size - Size of feature's register set in bytes.
>   * Params - Set if DFH has a list of parameter blocks.
> -  * Group - Id of group if feature is part of a group.
> -  * Instance - Id of instance of feature within a group.
> +  * Group - ID of group if feature is part of a group.
> +  * Instance - ID of feature instance within a group.
>
> - Offset 0x28 if feature has parameters
>
> -  * Next - Offset to the next parameter block in 8 byte words. If EOP set, size in 8 byte words of last parameter.
> +  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
> +    the value is size in 8 byte words of last parameter.
>   * Param Version - Version of Param ID.
>   * Param ID - ID of parameter.
>
> - Offset 0x30
>
> -  * Parameter Data - Parameter data whose size and format is defined by version and ID of the parameter.
> +  * Parameter Data - Parameter data whose size and format is defined by
> +    version and ID of the parameter.
>
> Open discussion
> ===============
>
> Thanks.
>
> -- 
> An old man doll... just what I always wanted! - Clara
>
