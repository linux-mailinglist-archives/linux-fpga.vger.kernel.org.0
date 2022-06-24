Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC8558FF0
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiFXEYw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 00:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFXEYw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 00:24:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8768089;
        Thu, 23 Jun 2022 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044691; x=1687580691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVDxIvarWkuRah5cpv92jCl+ab4t1rlKwD8uPlR7P2s=;
  b=hq1jzfcWVFxVXUL91zp8yqUfAAVud8iC4A9gg97NOfh3IjUNO5wdkr/a
   QVg0YCgw9Xqa5TYNptJhxio15jVcnK0bM7tMNEsFu0q616cWvbmTYfY2j
   efsVrzp3BZT91xExwEmyZwfa77pK8syfYnPZN2VWk1BtnKruP1qwLYNad
   GQB4jB9z9fkYEu1gUt/2STLeAIncizfVbgHLspP32VInv8LTWCEu/hxch
   HIjwX3BUcvWRjGLIl5PF3lObU/VUJmoFE8aspKnKSz/iP5lLGAtWxGaFp
   mzTe0sfvb5cWRZEs13DgGEXWxS5+3P4n3b/vEwTuaDwaUpodBEJu7oKxA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260736270"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="260736270"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="915522842"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2022 21:24:48 -0700
Date:   Fri, 24 Jun 2022 12:16:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v22 0/5] Microchip Polarfire FPGA manager
Message-ID: <20220624041637.GA1979449@yilunxu-OptiPlex-7050>
References: <20220623163248.3672-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623163248.3672-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 23, 2022 at 07:32:43PM +0300, Ivan Bornyakov wrote:
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
>   v12 -> v13:
>    * fpga-mgr: separate fpga_mgr_parse_header_buf() from
>      fpga_mgr_write_init_buf()
>    * fpga-mgr: introduce FPGA_MGR_STATE_PARSE_HEADER and
>      FPGA_MGR_STATE_PARSE_HEADER_ERR fpga_mgr_states
>    * fpga-mgr: rename fpga_mgr_write_init_sg() to fpga_mgr_prepare_sg()
>      and rework with respect to a new fpga_mgr_parse_header_buf()
>    * fpga-mgr: rework write accounting in fpga_mgr_buf_load_sg() for
>      better clarity
>    * microchip-spi: rename MPF_STATUS_POLL_TIMEOUT to
>      MPF_STATUS_POLL_RETRIES
>    * microchip-spi: add comment about status reading quirk to
>      mpf_read_status()
>    * microchip-spi: rename poll_status_not_busy() to mpf_poll_status()
>      and add comment.
>    * microchip-spi: make if statement in mpf_poll_status() easier to
>      read.
>   v13 -> v14:
>    * fpga-mgr: improvements from Xu Yilun in
>       - fpga_mgr_parse_header_buf()
>       - fpga_mgr_write_init_buf()
>       - fpga_mgr_prepare_sg()
>       - fpga_mgr_buf_load_sg()
>    * fpga-mgr: add check for -EAGAIN from fpga_mgr_parse_header_buf()
>      when called from fpga_mgr_buf_load_mapped()
>    * microchip-spi: remove excessive cs_change from second spi_transfer
>      in mpf_read_status()
>    * microchip-spi: change type of components_size_start,
>      bitstream_start, i from size_t to u32 in mpf_ops_parse_header()
>   v14 -> v15: eliminate memcpy() in mpf_ops_write()
>     Eliminate excessive memcpy() in mpf_ops_write() by using
>     spi_sync_transfer() instead of spi_write().
>   v15 -> v16:
>    * microchip-spi: change back components_size_start and
>      bitstream_start variables types to size_t, i - to u16 in
>      mpf_ops_parse_header()
>    * fpga-mgr: rename fpga_parse_header_buf() to
>      fpga_parse_header_mapped(). It serves only mapped FPGA image now,
>      adjust it accordingly.
>    * fpga-mgr: separate fpga_mgr_parse_header_sg_first() and
>      fpga_mgr_parse_header_sg() from fpga_mgr_prepare_sg()
>   v16 -> v17:
>    * fpga-mgr: return size of allocated header from
>      fpga_mgr_parse_header_sg(), add `char **ret_buf` to function args
>      to save pointer to allocated header. This allow us to call
>      fpga_mgr_write_init_buf() with exact size of allocated header.
>    * document parse_header() callback in fpga-mgr.rst
>   v17 -> v18:
>    * fpga-mgr: change back fpga_mgr_parse_header_sg() to return
>      allocated buffer but set buffer size into output parameter
>    * fpga-mgr: check returned pointer from krealloc for ZERO_OR_NULL_PTR
>      in fpga_mgr_paese_header_sg() as krealloc may return ZERO_SIZE_PTR.
>    * fpga-mgr: in fpga_mgr_prepare_sg() return fpga_mgr_write_init() on
>      fast path only when both initial_header_size and parse_header() are
>      not defined.
>    * docs: fpga-mgr: a few rewords from Xu Yilun
>   v18 -> v19:
>    * microchip-spi: split multiple assignments on a single line in
>      functions mpf_read_status() and mpf_ops_parse_header()
>    * fpga-mgr: add braces {} around "else if" arm in
>      fpga_mgr_prepare_sg()
>    * fpga-mgr: don't reuse krealloc() arg in fpga_mgr_parse_header_sg().
>      If krealloc() returns NULL, it doesn't free the original.
>   v19 -> v20:
>    * fpga-mgr: initialize info->header_size with
>      mops->initial_header_size at fpga_mgr_load().
>    * fpga-mgr: add mops->skip_header boolean flag. Adjust skipping
>      header before write to check against skip_header flag instead of
>      mere presence of info->header_size.
>    * fpga-mgr: split check for ZERO_OR_NULL_PTR() after realloc() in
>      fpga_mgr_parse_header_sg() function to check against zero header +
>      check against NULL returned from realloc().
>    * docs: fpga-mgr: adjust for skip_header flag.
>    * microchip-spi: add skip_header to mpf_ops.
>   v20 -> v21:
>    * fpga-mgr: in function fpga_mgr_parse_header_sg(), after
>      reallocation of a buffer for a new header, copy only exceeding
>      part, since realloc preserve old buffer content.
>    * fpga-mgr: in function fpga_mgr_buf_load_sg() instead of manually
>      counting fragments with header that should be skipped, use
>      sg_miter_skip().
>    * fpga-mgr: add tag "Suggested-by: Xu Yilun <yilun.xu@intel.com>"
>      since all changes in fpga-mgr was his ideas.
>    * MAINTAINERS: add entry for Microchip PolarFire FPGA drivers as
>      Conor Dooley suggested.
>   v21 -> v22:
>    * fpga-mgr: in function fpga_mgr_buf_load_sg() drop excessive
>      sg_miter_stop() when sg_miter_skip() reaches end of sg_mapping_iter
> 
> Ivan Bornyakov (5):
>   fpga: fpga-mgr: support bitstream offset in image buffer
>   docs: fpga: mgr: document parse_header() callback
>   fpga: microchip-spi: add Microchip MPF FPGA manager
>   dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
>   MAINTAINERS: add Microchip PolarFire FPGA drivers entry
> 
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
>  Documentation/driver-api/fpga/fpga-mgr.rst    |  27 +-
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |   8 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/fpga-mgr.c                       | 223 ++++++++--
>  drivers/fpga/microchip-spi.c                  | 398 ++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h                 |  24 +-
>  8 files changed, 700 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/microchip-spi.c

Applied the series to for-next

Thanks for the improvement to FPGA core.
Yilun

> 
> -- 
> 2.36.1
> 
