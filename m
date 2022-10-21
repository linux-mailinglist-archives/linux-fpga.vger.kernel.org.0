Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9718460725F
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJUIcG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJUIbx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 04:31:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E921CD65;
        Fri, 21 Oct 2022 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341042; x=1697877042;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iStXbW6utP2Sr5Eu3lyDBrnn9cA6vtUAUyNGvoK3NtY=;
  b=Uf7JYtBywDSGtclTl8KAQ32yCvKAI6TjiFi3YDrgVn+NbIQonDa/x7cM
   RUodL6IlY5VTHVBrSiaNAPYzwIYJTz+6H1rQTjYTaTDNnTTvYmQg2pSjY
   AGms6hD1nAtvJa/GVDiXltS9jmysp0w9U5tTfo3UkT5r0H4x/fmU5fowY
   Q7oH6qmKghprkhHWQFWRNuRgzjjoYYmFm9EqvaTu4Pb4ngRAxe+c2oXfn
   OTywvp46gsgOKiVlEoiDtwUoVFJUalwkKSpMEH9qLMP/Vt5omXZY1Tvi/
   Gjw8dowt0DsZZ2NpXKZ3ZKxml0Mrymw+jH5Tp12Uup1SV18d9C0PdeqhO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="371162339"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="371162339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:29:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719594843"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719594843"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:29:00 -0700
Date:   Fri, 21 Oct 2022 11:28:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
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
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>,
        marpagan@redhat.com
Subject: Re: [PATCH v4 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <20221020212610.697729-2-matthew.gerlach@linux.intel.com>
Message-ID: <d265dae0-fe4b-8ac0-fb9e-2a7345b279a2@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation describing the extensions provided by Version
> 1 of the Device Feature Header (DFHv1).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4: Remove marketing speak and separate v0 and v1 descriptions.
>     Fix errors reported by "make htmldocs".
> 
> v3: no change
> 
> v2: s/GUILD/GUID/
>     add picture
> ---
>  Documentation/fpga/dfl.rst | 96 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..12365be435a8 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -561,6 +561,102 @@ new DFL feature via UIO direct access, its feature id should be added to the
>  driver's id_table.
>  
>  
> +Device Feature Header - Version 0
> +===========================================
> +The format of Version 0 of a Device Feature Header (DFH) is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +
> +Offset 0x00
> +Type - The type of DFH (e.g. FME, AFU, or private feature).
> +DFH VER - The version of the DFH.
> +Rsvd - Currently unused.
> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +Next - The offset of the next DFH in the DFL from the start of the DFH.
> +If EOL is set, Next refers to size of mmio for last feature in the list.
> +ID - If Type field is 'private feature', then ID of the private feature.
> +
> +Offset 0x08
> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier
> +if Type is FME or AFU.
> +
> +Offset 0x10
> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> +if Type is FME or AFU.
> +
> +
> +Device Feature Header - Version 1
> +===========================================

While this is structurally better than the previous one. I'd still include
at least one paragraph about the purpose. Something along these lines 
(picked from v3 + edited the marketing speak/v0 compare away from it):

Version 1 of the Device Feature Header (DFHv1) provides flexibility and 
extensibility to hardware designs using Device Feature Lists. It is a
standardized mechanism for features to describe parameters/capabilities to 
software.

With DFHv1:
* GUID is mandatory for all types
* The register space of the feature is decoupled from the location of the DFH
* A list of parameter values associates to a particular feature.

After that, the header itself makes much more sense already.

> +The format of Version 1 of a Device Feature Header (DFH) is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +    |63                 Address/Offset                            1|  Rel  0| 0x18

Should this mention it's addr/offs of registers? As is it's bit hard to 
figure out from the diagram w/o the extra description. I think you have 
plenty of space for adding that extra bit of info.

> +    +-----------------------------------------------------------------------+
> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
> +    +-----------------------------------------------------------------------+
> +    |63 Next      34|RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0| 0x30
> +    +-----------------------------------------------------------------------+
> +
> +                                  ...
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0|
> +    +-----------------------------------------------------------------------+
> +
> +Offset 0x00
> +Type - The type of DFH (e.g. FME, AFU, or private feature).
> +DFH VER - The version of the DFH.
> +Rsvd - Currently unused.
> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +Next - The offset of the next DFH in the DFL from the start of the DFH.
> +If EOL is set, Next refers to size of mmio for last feature in the list.
> +ID - If Type field is 'private feature', then ID of the private feature.
> +
> +Offset 0x08
> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
> +
> +Offset 0x10
> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> +if Type is FME or AFU.

A copy-paste error?

> +
> +Offset 0x18
> +Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
> +absolute address for the location of the feature's registers.
> +If Rel bit is clear, then the feature's registers start at the
> +offset from the start of the DFH.
> +
> +Offset 0x20
> +Reg Size - Size of feature's register set.
> +Params - Set if DFH has one or more parameter blocks.
> +Group - Id of group if feature is part of a group.
> +Instance - Id of instance of feature within a group.
> +
> +Offset 0x28 if feature has parameters
> +Next - High 30 bits of a 32 bit aligned offset to the next parameter block.
> +If EOP set, size of last parameter.
> +Param Version - Version of Param ID.
> +Param ID - ID of parameter.
> +
> +Offset 0x30
> +Parameter Data - Parameter data whose size and format is defined by version
> +and ID of the parameter.

I'd reverse the order and say "ID and version" (kind of major thing 
first).

> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> 

-- 
 i.

