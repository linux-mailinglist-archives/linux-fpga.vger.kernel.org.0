Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2110E52E3EB
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 06:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbiETEhs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 May 2022 00:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbiETEhp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 May 2022 00:37:45 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C190CE1;
        Thu, 19 May 2022 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
         references;
        bh=MPfE5EJBVkzimd2oyGlmPUA4ytw/j02j1YCnHKRIQnY=;
        b=AGpWfN8URGxgEM1veEHHYthyUNXn1RS/H82Ch92fxc8I8sjpfWNbEVsPMy0e4ZINAw7k78uPq18SO
         ZB0Xy/pxN0aMQb3tq0kimRfqFwARnKpcnB4FqVDc4k7/4US3zbtoLkJ4yrEk3hL1fHc8yfQ1lFjvGF
         7eL1ZBWKgk7+Fo1tSl3ipptVGKNGqwLcykN6cnKAAeoPbIOLvjrfjZe5Pm3XWvn6Yb5x5qE4BLYjY1
         QrYe9v3cmbR7mzFU53B1TzCC9vjozuaCuHQOfdifDYV2SzpdjXTtEuELz//o9GxYcomIe9ugyiCbj2
         TM8AbKFVo7lgh1AZlufrhmw/e3CTZsg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000015,0.012860)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.067603), Hit: No, Details: v2.39.0; Id: 15.52katf.1g3fs2o1h.653ve; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 20 May 2022 07:37:10 +0300
Date:   Fri, 20 May 2022 07:15:30 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, i.bornyakov@metrotek.ru
Subject: Re: [PATCH v12 0/3] Microchip Polarfire FPGA manager
Message-ID: <20220520041530.aihtvyx6zsdtackn@x260>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 13, 2022 at 07:27:52PM +0300, Ivan Bornyakov wrote:
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
>   v5 -> v6: fix patch applying
>      I forgot to clean up unrelated local changes which lead to error on
>      patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
>      applying on vanilla kernel.
>   v6 -> v7: fix binding doc to pass dt_binding_check
>   v7 -> v8: another fix for dt_binding_check warning
>   v8 -> v9:
>    * add another patch to support bitstream offset in FPGA image buffer
>    * rework fpga_manager_ops.write_sg() back to fpga_manager_ops.write()
>    * move image header parsing from write() to write_init()
>   v9 -> v10:
>    * add parse_header() callback to fpga_manager_ops
>    * adjust fpga_mgr_write_init[_buf|_sg]() for parse_header() usage
>    * implement parse_header() in microchip-spi driver
>   v10 -> v11: include missing unaligned.h to microchip-spi
>      fix error: implicit declaration of function 'get_unaligned_le[16|32]'
>   v11 -> v12:
>    * microchip-spi: double read hw status, ignore first read, because it
>      can be unreliable.
>    * microchip-spi: remove sleep between status readings in
>      poll_status_not_busy() to save a few seconds. Status is polled on
>      every 16 byte writes - that is quite often, therefore
>      usleep_range() accumulate to a considerable number of seconds.
> 
> Ivan Bornyakov (3):
>   fpga: fpga-mgr: support bitstream offset in image buffer
>   fpga: microchip-spi: add Microchip MPF FPGA manager
>   dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
> 
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 +++
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/fpga-mgr.c                       | 150 +++++--
>  drivers/fpga/microchip-spi.c                  | 371 ++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h                 |  13 +-
>  6 files changed, 552 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/microchip-spi.c
> 
> -- 
> 2.35.1
> 

Friendly ping.

