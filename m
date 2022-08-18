Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11956597B78
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Aug 2022 04:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiHRCWe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiHRCWe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 22:22:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F2290C5F;
        Wed, 17 Aug 2022 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660789353; x=1692325353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yrKAFnVPaGNMYYATTJbAtyQVPe2c1G8tf11MardVXvs=;
  b=J/KZkT7tzm+rzM5p0TEYbrc0QLl+d7CGCAPzsUWriQtV5RgIJ2TIAKzS
   KISmPGlJaQRPnWP2wvIcUTd3XapdRewNFB4/qNY+rYK+5v+DpjspLRH14
   NNMqYFm4L2gUzcDgz5Z/7QMgf370z0x8bTsrKOjynUk7bWjSWYUnU/3VU
   TvwzLz0kdcjy7agIS+J6LWghr2b7CPzTMVxI7GRy+YONsqdgg6W7Tsiq3
   Sa0OXDfqLsYxkBSfQes0WOJbZFsiTdUlW5yJl7pn4HQdqIDwHEcblR24q
   gbGA0DqRm7lYZhkb4SX5EBPTVxdyeo9oNDT8f7tmv8IP0Wtn8LhSEsMJu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279613721"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="279613721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="636626805"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 19:22:29 -0700
Date:   Thu, 18 Aug 2022 10:13:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru,
        yilun.xu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <Yv2gQnN+XlW3CWjl@yilunxu-OptiPlex-7050>
References: <20220815132157.8083-1-i.bornyakov@metrotek.ru>
 <20220815132157.8083-2-i.bornyakov@metrotek.ru>
 <Yvr6SY5WGXlYiLig@yilunxu-OptiPlex-7050>
 <20220816045841.irhr5vigemdqknaw@x260>
 <Yvs0jieXsyzhn8q9@yilunxu-OptiPlex-7050>
 <20220817090413.ywf7wescwj2manif@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817090413.ywf7wescwj2manif@x260>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-17 at 12:04:13 +0300, Ivan Bornyakov wrote:
> On Tue, Aug 16, 2022 at 02:09:18PM +0800, Xu Yilun wrote:
> > On 2022-08-16 at 07:58:41 +0300, Ivan Bornyakov wrote:
> > > On Tue, Aug 16, 2022 at 10:00:41AM +0800, Xu Yilun wrote:
> > > > On 2022-08-15 at 16:21:56 +0300, Ivan Bornyakov wrote:
> > > > > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > > > > slave SPI interface with .bit formatted uncompressed bitstream image.
> > > > 
> > > > Not sure if something is missed.
> > > > 
> > > > https://lore.kernel.org/all/20220729145757.GA2601292@yilunxu-OptiPlex-7050/
> > > > 
> > > > I was considering if a generic driver for lattice slave SPI sysCONFIG
> > > > interface could be introduced. From machxo2 & ecp5 Programming Usage
> > > > Guide, or others in this series, they basically use the same reconfigure
> > > > interface & protocol.
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > 
> > > I only have HW with ECP5, can't vouch for the rest.
> > 
> > I understand your concern, but having separate drivers for the same IP on
> > different boards makes the maintaining harder.
> > 
> > We don't have to make everything fine, but start with machxo2 and ecp5
> > first. If the change affects machxo2, other people may help.
> > 
> > Thanks,
> > Yilun
> > 
> 
> Hi, Yilun.
> 
> To clear things out, considering what Daniel said in
> https://lore.kernel.org/linux-fpga/20220816074216.GA31706@homes.emlix.com/
> you still don't want separate ECP5 driver, or this v6 is OK and review

I still perfer one sysCONFIG driver. If I understand right, the 2
reprogramming modes and the command sets are within the scope of
sysCONFIG spec. So they could be all supported in sysCONFIG driver, and
I assume some config option could be made to adapt different boards.

Thanks,
Yilun

> continues?
> 
