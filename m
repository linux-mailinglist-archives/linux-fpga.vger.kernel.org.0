Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869CC4EC80D
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Mar 2022 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiC3PT7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Mar 2022 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiC3PT6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Mar 2022 11:19:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00679559B;
        Wed, 30 Mar 2022 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648653493; x=1680189493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=caZ836i7qELf2LoMLC34//yQfP4NzaUfxpHNmcCyr3Y=;
  b=nGs7Tk/z8JdsO2vJ+Siq6MOLTiVY/jSIoFEvdOPIw/N+Gr3qOjxg9H7Y
   69OcxFmFejmqld1odCGUYR3Pj+wfQVITMI8NlaIWMrSZVHU3zkp74Py+P
   plgxEdEDFhjGdkQD/BYmfbwYbL4VUcthCh/iOvFn54CPupzTIb29Kym8x
   01nc3UMXkJqiteT+b61ajBVlI08BJ7UIoMA755n5MJzWsODHnHdoqAyKH
   u4bWyJqtkFn4CBHvGZ5K/f1M8waTcO7C53OyLAdW1M/8uiV8HYzGOOauD
   vrWk0adE2SC8FQImIxB0DAVjVYsNZiuy7SxSUkN98+y1wjQdKFjdEKsw8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247069334"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="247069334"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565582039"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2022 08:17:59 -0700
Date:   Wed, 30 Mar 2022 23:10:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Microchip Polarfire FPGA manager
Message-ID: <20220330151045.GB214615@yilunxu-OptiPlex-7050>
References: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 22, 2022 at 10:15:50PM +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Microchip Polarfire
> FPGAs over slave SPI interface with .dat formatted bitsream image.
> 
> Changelog:
>   v1 -> v2: fix printk formating
>   v2 -> v3:
>    * replace "microsemi" with "microchip"
>    * replace prefix "microsemi_fpga_" with "mpf_"
>    * more sensible .compatible and .name strings
>    * remove unused defines STATUS_SPI_VIOLATION and STATUS_SPI_ERROR
>   v3 -> v4: fix unused variable warning
>     Put 'mpf_of_ids' definition under conditional compilation, so it
>     would not hang unused if CONFIG_OF is not enabled.
>   v4 -> v5:
>    * prefix defines with MPF_
>    * mdelay() -> usleep_range()
>    * formatting fixes
>    * add DT bindings doc
>    * rework fpga_manager_ops.write() to fpga_manager_ops.write_sg()
>      We can't parse image header in write_init() because image header
>      size is not known beforehand. Thus parsing need to be done in
>      fpga_manager_ops.write() callback, but fpga_manager_ops.write()
>      also need to be reenterable. On the other hand,
>      fpga_manager_ops.write_sg() is called once. Thus, rework usage of
>      write() callback to write_sg().

Sorry for late reply.

write_sg is for hardwares capable of handling sg buffers in batches. It
does not make sense we must implement write_sg() if the image header is
not fixed. They are not related.

The real problem is we lack the support for variable image header. So
maybe add the support in fpga manager core.

Thanks,
Yilun


>   v5 -> v6: fix patch applying
>      I forgot to clean up unrelated local changes which lead to error on
>      patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
>      applying on vanilla kernel.
>   v6 -> v7: fix binding doc to pass dt_binding_check
>   v7 -> v8: another fix for dt_binding_check warning
> 
> Ivan Bornyakov (2):
>   fpga: microchip-spi: add Microchip MPF FPGA manager
>   dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
> 
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
>  drivers/fpga/Kconfig                          |  10 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/microchip-spi.c                  | 448 ++++++++++++++++++
>  4 files changed, 503 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/microchip-spi.c
> 
> -- 
> 2.34.1
> 
