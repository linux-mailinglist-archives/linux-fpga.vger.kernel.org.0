Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E38659093
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 19:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiL2SsI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2SsH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 13:48:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD63B1F1;
        Thu, 29 Dec 2022 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672339686; x=1703875686;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qZZLPhYRwJUWcy1yxrLppeCCn8zrsORqz1OxonQ5PuE=;
  b=Rq5r8D/aHn2pB4Eb+araofnmDr62h7Zl6oyyaYvTjZ4srwkrDktr50Ck
   yizUter/VTEEMmedQDhNBAO8DVfbi6GsvWqRsRGcmv6EZYUKsAJCf1fkl
   xdjZo6YSN99D3F/SUTJk3U7AJ/SCHj/Wfq90louxIMSn7B9VBmtFQxh1b
   QzmBu9tyCt1jhYabOCWH+VcKrcO+cTN2L8LuGkqURTCJpPtMVgWOZbueH
   SbgAfPm/i7aTTmFUNuwXLmhv4XvYy50Bq0i6jLEyZs6TE1r2zz3TKclRV
   ylg9Ci4cJer/d64NyJEccEpodIJvK/A0DGK9HinrN3O/cK1XXkQrGIhmK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="300785052"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="300785052"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 10:48:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686061358"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="686061358"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 10:48:05 -0800
Date:   Thu, 29 Dec 2022 10:48:31 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <e12481e4-9d2c-9afe-a3e9-9c995c788134@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2212291033560.1857691@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-2-matthew.gerlach@linux.intel.com> <e12481e4-9d2c-9afe-a3e9-9c995c788134@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-82988109-1672339711=:1857691"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-82988109-1672339711=:1857691
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 29 Dec 2022, Tom Rix wrote:

>
> On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> 
>> Add documentation describing the extensions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>> 
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> v8: fix section titles
>> 
>> v7: shorten long lines and wording suggestions by bagasdotme@gmail.com
>> 
>> v6: no change
>> 
>> v5: use nested list for field descriptions
>>      clean up prose
>>      add reviewed-by and comments from Ilpo Järvinen
>> 
>> v4: Remove marketing speak and separate v0 and v1 descriptions.
>>      Fix errors reported by "make htmldocs".
>> 
>> v3: no change
>> 
>> v2: s/GUILD/GUID/
>>      add picture
>> ---
>>   Documentation/fpga/dfl.rst | 112 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 112 insertions(+)
>> 
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 15b670926084..264b476fc6ac 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -561,6 +561,118 @@ new DFL feature via UIO direct access, its feature id 
>> should be added to the
>>   driver's id_table.
>> 
>
> I think a better location for this section would be in the beginning after 
> the
>
> Device Feature List (DFL) Overview
>
> The reader will be looking for the details of the Header once they have read 
> the overview.
>
> It would be handy if they were next

I agree that moving the new Documentation immediately after the Overview 
would be better.

>
>> +Device Feature Header - Version 0
>> +=================================
>> +Version 0 (DFHv0) is the original version of the Device Feature Header.
>> +The format of DFHv0 is shown below::
>> +
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 
>> 0| 0x00
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L 
>> 0| 0x08
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H 
>> 0| 0x10
>> + 
>> +-----------------------------------------------------------------------+
>> +
>> +- Offset 0x00
>> +
>> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +  * DFH VER - The version of the DFH.
>> +  * Rsvd - Currently unused.
>> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
>> +  * Next - The offset of the next DFH in the DFL from the DFH start.
>> +    If EOL is set, Next is the size of MMIO of the last feature in the 
>> list.
>
> Missed describing feature revision bits 12-15
>
> There as two VER's, it would be clearer if they were different. maybe REV for 
> bits 12-15
>
> Similar below.

Thanks for the feedback.  REV is a good suggestion and more accurate.

>
>> +  * ID - The feature ID if Type is private feature.
>> +
>> +- Offset 0x08
>> +
>> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique 
>> Identifier
>> +    (present only if Type is FME or AFU).
>> +
>> +- Offset 0x10
>> +
>> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique 
>> Identifier
>> +    (present only if Type is FME or AFU).
>> +
>> +
>> +Device Feature Header - Version 1
>> +=================================
>> +Version 1 (DFHv1) of the Device Feature Header adds the following 
>> functionality:
>> +
>> +* Provides a standardized mechanism for features to describe
>> +  parameters/capabilities to software.
>> +* Standardize the use of a GUID for all DFHv1 types.
>> +* Decouples the DFH location from the register space of the feature 
>> itself.
>> +
>> +The format of Version 1 of the Device Feature Header (DFH) is shown 
>> below::
>> +
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 
>> 0| 0x00
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                                 GUID_L 
>> 0| 0x08
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                                 GUID_H 
>> 0| 0x10
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                   Reg Address/Offset                      1|  Rel 
>> 0| 0x18
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance 
>> 0| 0x20
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID 
>> 0| 0x28
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data 
>> 0| 0x30
>> + 
>> +-----------------------------------------------------------------------+
>> +
>> +                                  ...
>> +
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID 
>> 0|
>> + 
>> +-----------------------------------------------------------------------+
>> +    |63                 Parameter Data 
>> 0|
>> + 
>> +-----------------------------------------------------------------------+
>> +
>> +- Offset 0x00
>> +
>> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
>> +  * DFH VER - The version of the DFH.
>> +  * Rsvd - Currently unused.
>> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
>> +  * Next - The offset of the next DFH in the DFL from the DFH start.
>> +    If EOL is set, Next is the size of MMIO of the last feature in the 
>> list.
>
> Units of size ?
>
> Tom

Historically, the units of the size been in bytes. It might make sense to 
redefine this field to bits 39-19 and change the unit to 64 bit words. This
would also be consistent with DFHv1 parameter blocks and enforce 64 bit 
alignment of the DFH.

Thanks for the feedback,
Matthew Gerlach

>
>> +  * ID - The feature ID if Type is private feature.
>> +
>> +- Offset 0x08
>> +
>> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique 
>> Identifier.
>> +
>> +- Offset 0x10
>> +
>> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique 
>> Identifier.
>> +
>> +- Offset 0x18
>> +
>> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 
>> bits
>> +    of a 16-bit aligned absolute address of the feature's registers. 
>> Otherwise
>> +    the value is the offset from the start of the DFH of the feature's 
>> registers.
>> +
>> +- Offset 0x20
>> +
>> +  * Reg Size - Size of feature's register set in bytes.
>> +  * Params - Set if DFH has a list of parameter blocks.
>> +  * Group - Id of group if feature is part of a group.
>> +  * Instance - Id of feature instance within a group.
>> +
>> +- Offset 0x28 if feature has parameters
>> +
>> +  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
>> +    size in 8 byte words of last parameter.
>> +  * Param Version - Version of Param ID.
>> +  * Param ID - ID of parameter.
>> +
>> +- Offset 0x30
>> +
>> +  * Parameter Data - Parameter data whose size and format is defined by
>> +    version and ID of the parameter.
>> +
>>   Open discussion
>>   ===============
>>   FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial 
>> reconfiguration
>
>
--8323328-82988109-1672339711=:1857691--
