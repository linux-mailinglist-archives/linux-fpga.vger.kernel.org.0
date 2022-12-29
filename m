Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCBA658E5B
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiL2Pch (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiL2Pch (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 10:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8113E26
        for <linux-fpga@vger.kernel.org>; Thu, 29 Dec 2022 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672327911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3NN2Mip5QK+Z02dH68Rq+WIBZOSpgwllYxpq3yU+XE=;
        b=dGU8a0f6+mUhu0S7oFRn7P0dv3TyjN1J4g1SDcYvSKOkLttW3olyl2qHpRgtQtHFJGDogT
        ZB8SZV3ZBR1gj79rpK/V6eKFAHY4ifXmqwVJ6YACXyiPP78OB3bla9k56reXLa497J1/zu
        BGpM1Pnyv+o62pMifs8363H5nruYpgE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-JukDSwpePOyXgJ9qt7HV2w-1; Thu, 29 Dec 2022 10:31:50 -0500
X-MC-Unique: JukDSwpePOyXgJ9qt7HV2w-1
Received: by mail-qt1-f197.google.com with SMTP id e18-20020ac84912000000b003a96d6f436fso7251401qtq.0
        for <linux-fpga@vger.kernel.org>; Thu, 29 Dec 2022 07:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3NN2Mip5QK+Z02dH68Rq+WIBZOSpgwllYxpq3yU+XE=;
        b=QsjWxcyvBdpecls77ATviQHGWaqsuy6jehqXooFTnCRrJxl89jO4whViogK3etE0rD
         B+0xgZQVZRh2TYYC/IPYWHYONE1Amisb2xdzCzhiSnyWZJcobSvwqkTEEmmbtEqW2DlW
         Hht+uuC0qobJE/PaiBGBYtl5raPTe6pxjXVHyeQ8Px+BtLiARmAxuxBE5fEMeynWrTOf
         GT8p5jaU4LpzDFvUyxNs94oCMCkkjH3WOurDe4x2kQhWeZ9UJ4WYQaQ2YAxpWPOjZxbG
         IcWvFXEB/vJ7kRGAPHKUHPPmPfknT3I8pOm6cIjqrBmbfj9P2K2Pe1ll45lGywqxUMot
         PP9g==
X-Gm-Message-State: AFqh2kpFXv60jfXTNitDZ5NIC0jfEZ5p9wo7tdTlZZpoH0Jpv5HEO1Bw
        E7kwmQmSNYcR2U937C/uNDOP6+b4LIserKYriTHqrmNQ/e9dD7r6yodDxa1SDC9u3foG4VPFvnq
        9yMF4IZ2y3eGI4UrV0BRGEg==
X-Received: by 2002:ac8:4f49:0:b0:3a9:7ae4:eecb with SMTP id i9-20020ac84f49000000b003a97ae4eecbmr41615983qtw.54.1672327910071;
        Thu, 29 Dec 2022 07:31:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFAbnEpVvVC08+mn1l6MRytL6XVCY561sPWW44HBrRRMIslfh8TDoAaiAqAv1h+8aMiZ9g0Q==
X-Received: by 2002:ac8:4f49:0:b0:3a9:7ae4:eecb with SMTP id i9-20020ac84f49000000b003a97ae4eecbmr41615959qtw.54.1672327909765;
        Thu, 29 Dec 2022 07:31:49 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003a6947863e1sm11466198qtt.11.2022.12.29.07.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 07:31:49 -0800 (PST)
Subject: Re: [PATCH v8 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-2-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e12481e4-9d2c-9afe-a3e9-9c995c788134@redhat.com>
Date:   Thu, 29 Dec 2022 07:31:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221228181624.1793433-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add documentation describing the extensions provided by Version
> 1 of the Device Feature Header (DFHv1).
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v8: fix section titles
>
> v7: shorten long lines and wording suggestions by bagasdotme@gmail.com
>
> v6: no change
>
> v5: use nested list for field descriptions
>      clean up prose
>      add reviewed-by and comments from Ilpo Järvinen
>
> v4: Remove marketing speak and separate v0 and v1 descriptions.
>      Fix errors reported by "make htmldocs".
>
> v3: no change
>
> v2: s/GUILD/GUID/
>      add picture
> ---
>   Documentation/fpga/dfl.rst | 112 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 112 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..264b476fc6ac 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -561,6 +561,118 @@ new DFL feature via UIO direct access, its feature id should be added to the
>   driver's id_table.
>   
>   

I think a better location for this section would be in the beginning 
after the

Device Feature List (DFL) Overview

The reader will be looking for the details of the Header once they have 
read the overview.

It would be handy if they were next

> +Device Feature Header - Version 0
> +=================================
> +Version 0 (DFHv0) is the original version of the Device Feature Header.
> +The format of DFHv0 is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the DFH start.
> +    If EOL is set, Next is the size of MMIO of the last feature in the list.

Missed describing feature revision bits 12-15

There as two VER's, it would be clearer if they were different. maybe 
REV for bits 12-15

Similar below.

> +  * ID - The feature ID if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
> +
> +
> +Device Feature Header - Version 1
> +=================================
> +Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
> +
> +* Provides a standardized mechanism for features to describe
> +  parameters/capabilities to software.
> +* Standardize the use of a GUID for all DFHv1 types.
> +* Decouples the DFH location from the register space of the feature itself.
> +
> +The format of Version 1 of the Device Feature Header (DFH) is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +    |63                   Reg Address/Offset                      1|  Rel  0| 0x18
> +    +-----------------------------------------------------------------------+
> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
> +    +-----------------------------------------------------------------------+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0| 0x30
> +    +-----------------------------------------------------------------------+
> +
> +                                  ...
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0|
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0|
> +    +-----------------------------------------------------------------------+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset of the next DFH in the DFL from the DFH start.
> +    If EOL is set, Next is the size of MMIO of the last feature in the list.

Units of size ?

Tom

> +  * ID - The feature ID if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier.
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier.
> +
> +- Offset 0x18
> +
> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits
> +    of a 16-bit aligned absolute address of the feature's registers. Otherwise
> +    the value is the offset from the start of the DFH of the feature's registers.
> +
> +- Offset 0x20
> +
> +  * Reg Size - Size of feature's register set in bytes.
> +  * Params - Set if DFH has a list of parameter blocks.
> +  * Group - Id of group if feature is part of a group.
> +  * Instance - Id of feature instance within a group.
> +
> +- Offset 0x28 if feature has parameters
> +
> +  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
> +    size in 8 byte words of last parameter.
> +  * Param Version - Version of Param ID.
> +  * Param ID - ID of parameter.
> +
> +- Offset 0x30
> +
> +  * Parameter Data - Parameter data whose size and format is defined by
> +    version and ID of the parameter.
> +
>   Open discussion
>   ===============
>   FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration

