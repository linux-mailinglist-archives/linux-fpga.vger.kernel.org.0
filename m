Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470354AD44
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Jun 2022 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiFNJUO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Jun 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354730AbiFNJUN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 14 Jun 2022 05:20:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501241FBA;
        Tue, 14 Jun 2022 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655198413; x=1686734413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1zqpTqgp59Z99VrOl0GaDy6GAy94VFKx5+2iNEgIphk=;
  b=EbW7a17Liy96zOPxP2HJThjEkKFwgZTz4nJXD2WqhvRWcOKhmSYGcTM4
   qfou6GVXbJXomOevFMMu6mreGkgGYS7TmT0aVNivG4FH23FrH0w/Na0vq
   doUmNEO5q1nZ2VwtLyYqs71wS/c5JyytJg0h0DljoQDwR6YwCgQOYfuOr
   fRdqbSiXgnaT8YtRRVKOacol1hEGa91BBa/6ySPAz79tUzUzgCIapxBH6
   z0Momlyhl7AukzuadMYUlP4pUGnwYJjiM/xN23dJU0GCA8lvC8R+wtg1B
   0dQTduZ6/LzWndS9GbYoACA4Dhi5F7lC0+8fw5SyJHAr1EKeAgNmR34sH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279601071"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279601071"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673783811"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 02:20:08 -0700
Date:   Tue, 14 Jun 2022 17:12:07 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v18 0/4] Microchip Polarfire FPGA manager
Message-ID: <20220614091207.GA869905@yilunxu-OptiPlex-7050>
References: <20220611090531.9663-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611090531.9663-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jun 11, 2022 at 12:05:27PM +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Microchip Polarfire
> FPGAs over slave SPI interface with .dat formatted bitsream image.

Hi Ivan:

I've found some warnings/checks when running "checkpatch --strict",
please help fix them.

One of them is the krealloc issue. Some reference for you:
https://lkml.org/lkml/2013/3/14/558

BTW: You could check Documentation/process/submit-checklist.rst for more
guildlines. I think at least checkpatch, make htmldocs or make pdfdocs,
sparse is the basic checks for you.

Thanks,
Yilun

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
> 
> Ivan Bornyakov (4):
>   fpga: fpga-mgr: support bitstream offset in image buffer
>   docs: fpga: mgr: document parse_header() callback
>   fpga: microchip-spi: add Microchip MPF FPGA manager
>   dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
> 
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
>  Documentation/driver-api/fpga/fpga-mgr.rst    |  31 +-
>  drivers/fpga/Kconfig                          |   8 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/fpga-mgr.c                       | 235 +++++++++--
>  drivers/fpga/microchip-spi.c                  | 393 ++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h                 |  17 +-
>  7 files changed, 693 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/microchip-spi.c
> 
> -- 
> 2.35.1
> 
