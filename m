Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42722585216
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Jul 2022 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiG2PGs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Jul 2022 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiG2PGr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Jul 2022 11:06:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6C7E812;
        Fri, 29 Jul 2022 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659107207; x=1690643207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VLTg2DanJb0NwEo+jRGiYXD1Cu9WCDAEVpiydaB9dbg=;
  b=lWpTvNcsDHQfLaFGbaOg4Bj7CG5J0q6yxUf8MbWt794A/Vlzrs9n3O4O
   e+j1Df0VggDfDpIVhnaiPF59LnT0jyc4BMXsUE8wEieeAnaMHkT8G3lii
   c8Czs+oJKYtIulSl4lZkODHMzbGYwMn87rfGNpdYGhGtqyl7vTHTgr+NI
   HHp/J1QiWDUe8EGVzcAu+6Qnww5qjzo2o9zF9mndAuXznumIcpbQfZSwP
   ZQgCw3NYybmEEoYJeORb7yFCVa/wb98QRfl+1H+37VcFMC/GwGhYIdHrn
   xc5K+Su3o3OpofnGiqlJiwFBchlsy6RYcGfs3m0eQ86qCeslR9SpcI2ii
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288797737"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="288797737"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="660269187"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2022 08:06:43 -0700
Date:   Fri, 29 Jul 2022 22:57:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
  fpga mgr
Message-ID: <20220729145757.GA2601292@yilunxu-OptiPlex-7050>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220719112335.9528-3-i.bornyakov@metrotek.ru>
 <20220729090123.GA28299@homes.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729090123.GA28299@homes.emlix.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 29, 2022 at 11:01:24AM +0200, Daniel Glöckner wrote:
> Hi,
> 
> On Tue, Jul 19, 2022 at 02:23:35PM +0300, Ivan Bornyakov wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lattice,ecp5-fpga-mgr
> 
> Since this driver uses the same interface as the existing
> drivers/fpga/machxo2-spi.c driver, wouldn't it be advisable to use a
> similar compatible id, i.e. lattice,ecp5-slave-spi?

That's a good clue for me. I searched the machxo2 & ecp5 Programming
Usage Guide and seems they share the similar slave SPI sysCONFIG
interface, at least the command word tables are the same. So could we
have a generic driver for the lattice slave SPI sysCONFIG interface,
rather than create similar drivers for each board?

Thanks,
Yilun

> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - program-gpios
> > +  - init-gpios
> > +  - done-gpios
> 
> I think some of the GPIOs can be made optional by reading the status
> register or using the refresh command, assuming the slave spi interface
> stayed enabled after previous programming and we are not dealing with
> several chained FPGAs. But that can of course be left as an exercise for
> other developers.
> 
> Best regards,
> 
>   Daniel
