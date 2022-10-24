Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6F60B172
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Oct 2022 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiJXQXD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Oct 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiJXQWr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 24 Oct 2022 12:22:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D822A17999D;
        Mon, 24 Oct 2022 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666624103; x=1698160103;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z0suAyxf1/ZAu8tFjbvLacyB7CnvbP884nhki9jkwsc=;
  b=FGJoRQ2A+k+xu3St7RQ+seN6ScpaYuJMhLr1DbZnH1xxAFEYv3dUwOpi
   1wT/8rToMSqhwW9wv3+nGKnqbVipYUXcXTfcwTfKzyeQXMUREyzazYvYs
   myPvupTfF3tMFDushDtwJtGhHaZviJrl8IJrBkkF6Evvh90q6HJEpJq6P
   rpLR0yvQtUm+Gs8+bSdm6D9O41qHrZEbl1+O5FY7UB3EuZ/Gc77WYGLDB
   YdzubdPISe/CGy0ZL6EsxRNe2IEJa8N1UG3hjxBQYSv47+3eX6TW1TFmR
   Y3YUPrrgrGl4pA/x7T5i1RbXZV0iypXZBPrLCMZtMcEhuE+W5bolTvFgC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371655874"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="371655874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:01:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="662458157"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="662458157"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:01:42 -0700
Date:   Mon, 24 Oct 2022 08:01:59 -0700 (PDT)
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
Subject: Re: [PATCH v4 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <Y1IYPTOJaxTfLDQe@debian.me>
Message-ID: <alpine.DEB.2.22.394.2210240801360.2070724@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-2-matthew.gerlach@linux.intel.com> <Y1IYPTOJaxTfLDQe@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 21 Oct 2022, Bagas Sanjaya wrote:

> On Thu, Oct 20, 2022 at 02:26:07PM -0700, matthew.gerlach@linux.intel.com wrote:
>> +Device Feature Header - Version 0
>> +===========================================
>> +The format of Version 0 of a Device Feature Header (DFH) is shown below::
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0| 0x08
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0| 0x10
>> +    +-----------------------------------------------------------------------+
>> +
>> +Offset 0x00
>> +Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +DFH VER - The version of the DFH.
>> +Rsvd - Currently unused.
>> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
>> +Next - The offset of the next DFH in the DFL from the start of the DFH.
>> +If EOL is set, Next refers to size of mmio for last feature in the list.
>> +ID - If Type field is 'private feature', then ID of the private feature.
>> +
>> +Offset 0x08
>> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier
>> +if Type is FME or AFU.
>> +
>> +Offset 0x10
>> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
>> +if Type is FME or AFU.
>> +
>> +
>> +Device Feature Header - Version 1
>> +===========================================
>> +The format of Version 1 of a Device Feature Header (DFH) is shown below::
>> +
>> +    +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L                             0| 0x08
>> +    +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H                             0| 0x10
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Address/Offset                            1|  Rel  0| 0x18
>> +    +-----------------------------------------------------------------------+
>> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
>> +    +-----------------------------------------------------------------------+
>> +    |63 Next      34|RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
>> +    +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data                                     0| 0x30
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
>> +Offset 0x00
>> +Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +DFH VER - The version of the DFH.
>> +Rsvd - Currently unused.
>> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
>> +Next - The offset of the next DFH in the DFL from the start of the DFH.
>> +If EOL is set, Next refers to size of mmio for last feature in the list.
>> +ID - If Type field is 'private feature', then ID of the private feature.
>> +
>> +Offset 0x08
>> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
>> +
>> +Offset 0x10
>> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
>> +if Type is FME or AFU.
>> +
>> +Offset 0x18
>> +Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
>> +absolute address for the location of the feature's registers.
>> +If Rel bit is clear, then the feature's registers start at the
>> +offset from the start of the DFH.
>> +
>> +Offset 0x20
>> +Reg Size - Size of feature's register set.
>> +Params - Set if DFH has one or more parameter blocks.
>> +Group - Id of group if feature is part of a group.
>> +Instance - Id of instance of feature within a group.
>> +
>> +Offset 0x28 if feature has parameters
>> +Next - High 30 bits of a 32 bit aligned offset to the next parameter block.
>> +If EOP set, size of last parameter.
>> +Param Version - Version of Param ID.
>> +Param ID - ID of parameter.
>> +
>> +Offset 0x30
>> +Parameter Data - Parameter data whose size and format is defined by version
>> +and ID of the parameter.
>> +
>
> The offset fields list should be formatted with nested list (with
> prose improv):
>
> ---- >8 ----

Thanks for the good suggestion.

>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 12365be435a812..9c19ee62d4ac44 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -573,22 +573,27 @@ The format of Version 0 of a Device Feature Header (DFH) is shown below::
>     |63                                 GUID_H                             0| 0x10
>     +-----------------------------------------------------------------------+
>
> -Offset 0x00
> -Type - The type of DFH (e.g. FME, AFU, or private feature).
> -DFH VER - The version of the DFH.
> -Rsvd - Currently unused.
> -EOL - Set if this DFH is the end of the Device Feature List (DFL).
> -Next - The offset of the next DFH in the DFL from the start of the DFH.
> -If EOL is set, Next refers to size of mmio for last feature in the list.
> -ID - If Type field is 'private feature', then ID of the private feature.
> +The fields are:
>
> -Offset 0x08
> -GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier
> -if Type is FME or AFU.
> +  * Offset 0x00
>
> -Offset 0x10
> -GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> -if Type is FME or AFU.
> +    * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +    * DFH VER - The version of the DFH.
> +    * Rsvd - Currently unused.
> +    * EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +
> +    * Next - The offset of the next DFH in the DFL from the start of the DFH.
> +      If EOL is set, Next refers to size of mmio for last feature in the list.
> +
> +    * ID - Private feature ID if Type is private feature.
> +
> +  * Offset 0x08
> +
> +    * GUID_L - Least significant half of a 128-bit GUID if Type is FME or AFU.
> +
> +  * Offset 0x10
> +
> +    * GUID_H - Most significant half of a 128-bit GUID if Type if FME or AFU.
>
>
> Device Feature Header - Version 1
> @@ -619,43 +624,53 @@ The format of Version 1 of a Device Feature Header (DFH) is shown below::
>     |63                 Parameter Data                                     0|
>     +-----------------------------------------------------------------------+
>
> -Offset 0x00
> -Type - The type of DFH (e.g. FME, AFU, or private feature).
> -DFH VER - The version of the DFH.
> -Rsvd - Currently unused.
> -EOL - Set if this DFH is the end of the Device Feature List (DFL).
> -Next - The offset of the next DFH in the DFL from the start of the DFH.
> -If EOL is set, Next refers to size of mmio for last feature in the list.
> -ID - If Type field is 'private feature', then ID of the private feature.
> +The fields are:
>
> -Offset 0x08
> -GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
> +  * Offset 0x00
>
> -Offset 0x10
> -GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> -if Type is FME or AFU.
> +    * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +    * DFH VER - The version of the DFH.
> +    * Rsvd - Currently unused.
> +    * EOL - Set if this DFH is the end of the Device Feature List (DFL).
>
> -Offset 0x18
> -Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
> -absolute address for the location of the feature's registers.
> -If Rel bit is clear, then the feature's registers start at the
> -offset from the start of the DFH.
> +    * Next - The offset of the next DFH in the DFL from the start of the DFH.
> +      If EOL is set, Next refers to size of mmio for last feature in the list.
>
> -Offset 0x20
> -Reg Size - Size of feature's register set.
> -Params - Set if DFH has one or more parameter blocks.
> -Group - Id of group if feature is part of a group.
> -Instance - Id of instance of feature within a group.
> +    * ID - Private feature ID if Type is private feature.
>
> -Offset 0x28 if feature has parameters
> -Next - High 30 bits of a 32 bit aligned offset to the next parameter block.
> -If EOP set, size of last parameter.
> -Param Version - Version of Param ID.
> -Param ID - ID of parameter.
> +  * Offset 0x08
>
> -Offset 0x30
> -Parameter Data - Parameter data whose size and format is defined by version
> -and ID of the parameter.
> +    * GUID_L - Least significant half of a 128-bit GUID if Type is FME or APU.
> +
> +  * Offset 0x10
> +
> +    * GUID_H - Most significant half of a 128-bit GUID if Type is FME or AFU.
> +
> +  * Offset 0x18
> +
> +    * Address/Offset - If Rel bit is set, upper 63 bits of a 16-bit aligned
> +      absolute address for the location of feature registers; otherwise
> +      registers of the feature start at the offset from the start of the DFH.
> +
> +  * Offset 0x20
> +
> +    * Reg Size - Size of register set of the feature.
> +    * Params - Set if DFH has one or more parameter blocks.
> +    * Group - ID of group if the feature is part of a group.
> +    * Instance - ID of instance of the feature within a group.
> +
> +  * Offset 0x28 (if the feature has parameters)
> +
> +    * Next - Upper 30 bits of a 32-bit aligned offset to the next parameter
> +      block. If EOP is set, size of last parameter.
> +
> +    * Param Version - Version of Param ID.
> +    * Param ID - ID of parameter.
> +
> +  * Offset 0x30 (if the feature has parameters)
> +
> +    * Parameter Data - Parameter data whose size and format is defined by
> +      version and ID of the parameter.
>
> Open discussion
> ===============
>
> Thanks.
>
> -- 
> An old man doll... just what I always wanted! - Clara
>
