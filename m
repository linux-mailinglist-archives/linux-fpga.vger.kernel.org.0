Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC45E7D68
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiIWOkx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiIWOkv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 10:40:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06AAF1857;
        Fri, 23 Sep 2022 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663944050; x=1695480050;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fs2fxSNfqcm045ENtCdw6SPv/7P4W5SdGkbp+E5zDPs=;
  b=i+BwdRNi7rDZY/UqqxhbZHRtF4gNbate7cbADjOUl1qhk/F5DBDjyK3h
   QnMNfsHQEgVGY9JUHqe0OavUKGaVZAJu4IOVVzQDUB9nx/N/9fEUiYstQ
   xT0dDkHosU2Ah12vHmFeOy2OfBpwnnxbPo1kByGlLbzo/P0cffTBCbmdl
   Z9SYi03qbwYAchcy/3NrsLoclCIT6opp2phfG5KOEiYklR1NyT96bTJ7O
   zUUUm4bk2TvPnwh9YrrCPAUrfQZJWye/TPLhqtUBeQEYjx6aK879ZR/51
   d2FjSmJ1ViIRwFk/qedxV+m9cChDWXQ7XqYvQlf7LZJiGTCMUAUCUaI0u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302053273"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302053273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="865312354"
Received: from alutz-mobl.ger.corp.intel.com ([10.252.35.146])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:40:42 -0700
Date:   Fri, 23 Sep 2022 17:40:40 +0300 (EEST)
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
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 1/6] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <40e867ec-c7-66f-9db9-94f6132d587e@linux.intel.com>
Message-ID: <b0689af0-511-dd5d-8e3-cca69d609cb0@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-2-matthew.gerlach@linux.intel.com> <40e867ec-c7-66f-9db9-94f6132d587e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2146711104-1663944047=:1595"
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

--8323329-2146711104-1663944047=:1595
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 23 Sep 2022, Ilpo Järvinen wrote:

> On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:
> 
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > Add documentation describing the extensions provided by Version
> > 1 of the Device Feature Header (DFHv1).
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> > v2: s/GUILD/GUID/
> >     add picture
> > ---
> >  Documentation/fpga/dfl.rst | 49 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index 15b670926084..7c786b75b498 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -561,6 +561,55 @@ new DFL feature via UIO direct access, its feature id should be added to the
> >  driver's id_table.
> >  
> >  
> > +Extending the Device Feature Header - DFHv1
> > +===========================================
> > +The current 8 bytes of the Device Feature Header, hereafter referred to as
> > +to DFHv0, provide very little opportunity for the hardware to describe itself
> > +to software. Version 1 of the Device Feature Header (DFHv1) is being introduced
> > +to provide increased flexibility and extensibility to hardware designs using
> > +Device Feature Lists.  The list below describes some of the goals behind the
> > +changes in DFHv1:
> > +
> > +* Provide a standardized mechanism for features to describe
> > +  parameters/capabilities to software.
> > +* Standardize the use of a GUID for all DFHv1 types.
> > +* Decouple the location of the DFH from the register space of the feature itself.
> > +
> > +Modeled after PCI Capabilities, DFHv1 Parameters provide a mechanism to associate
> > +a list of parameter values to a particular feature.
> > +
> > +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUID standard
> > +across all types.
> > +
> > +With DFHv0, the register map of a given feature is located immediately following
> > +the DFHv0 in the memory space.  With DFHv1, the location of the feature register
> > +map can be specified as an offset to the DFHv1 or as an absolute address.  The DFHv1
> > +structure is shown below:
> > +
> > +    +-----------------------------------------------------------------------+
> > +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0|
> > +    +-----------------------------------------------------------------------+
> > +    |63                                 GUID_L                             0|
> > +    +-----------------------------------------------------------------------+
> > +    |63                                 GUID_H                             0|
> > +    +-----------------------------------------------------------------------+
> > +    |63                 Address/Offset                            1|  Rel  0|
> > +    +-----------------------------------------------------------------------+
> 
> Is something missing here given the layout is claimed (in 2/6) to be:
> 
> "DFHv1 Register Offset definitons
> In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA"
> 
> ?

Ah, I think I've figured it out, PARAM_HDR + PARAM_DATA combo is repeated 
n times (rather than the params being covered by the "PARAM_DATA")?

-- 
 i.

> > +    |63 Size of register set  32|Params 31|30 Group    16|15 Instance      0|
> > +    +-----------------------------------------------------------------------+
> > +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
> > +    +-----------------------------------------------------------------------+
> > +    |63                 Parameter Data                                     0|
> > +    +-----------------------------------------------------------------------+
> > +
> > +                                  ...
> > +
> > +    +-----------------------------------------------------------------------+
> > +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
> > +    +-----------------------------------------------------------------------+
> > +    |63                 Parameter Data                                     0|
> > +    +-----------------------------------------------------------------------+
> > +
> >  Open discussion
> >  ===============
> >  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> > 
> 
> 

--8323329-2146711104-1663944047=:1595--
