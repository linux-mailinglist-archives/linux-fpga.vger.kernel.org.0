Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7154F89D
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 15:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381145AbiFQNtz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jun 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFQNty (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Jun 2022 09:49:54 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6258B433B8;
        Fri, 17 Jun 2022 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=oRNl7sLDT2M1niS9iFlX8UVibPyyHljcjZhc79I3m3g=;
        b=YCWT/4O8q8u1FdC7N+RsT1LIx6PqDyalxJtJTyTq2/T8neIdi9TksR1CRULDMFNKhpXJ1eFA7kkHf
         yERE+R1IIuNTkeGKhLk+Pe39P8J+E6uWfgqo+UJ0V1IUW8VtqmwESxKgOAYUZxqsDjR/r08Ly/dHAE
         dVhCsDRqyaAIsQHBCZSGJZ7gkF5OxfpCkBK53Gfk/ZkIEmBBVD3cKRoPtqqLk3yXUW57JKBwA/flKW
         t+vq1u/GgbL+wYg0WWJw7J5M7Lbmlz9dL18jdwqZWVcQAT7t79IMJWdE46dd41gqJ4tAg3IuXVWllH
         12sVeL7tvE8vkuH56d9GyAOUKpj/POg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.023636)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.077008), Hit: No, Details: v2.40.0; Id: 15.52k3tm.1g5oupr6p.297c; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 17 Jun 2022 16:49:19 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v20 0/4] Microchip Polarfire FPGA manager
Date:   Fri, 17 Jun 2022 16:48:42 +0300
Message-Id: <20220617134846.19859-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Microchip Polarfire
FPGAs over slave SPI interface with .dat formatted bitsream image.

Changelog:
  v1 -> v2: fix printk formating
  v2 -> v3:
   * replace "microsemi" with "microchip"
   * replace prefix "microsemi_fpga_" with "mpf_"
   * more sensible .compatible and .name strings
   * remove unused defines STATUS_SPI_VIOLATION and STATUS_SPI_ERROR
  v3 -> v4: fix unused variable warning
    Put 'mpf_of_ids' definition under conditional compilation, so it
    would not hang unused if CONFIG_OF is not enabled.
  v4 -> v5:
   * prefix defines with MPF_
   * mdelay() -> usleep_range()
   * formatting fixes
   * add DT bindings doc
   * rework fpga_manager_ops.write() to fpga_manager_ops.write_sg()
     We can't parse image header in write_init() because image header
     size is not known beforehand. Thus parsing need to be done in
     fpga_manager_ops.write() callback, but fpga_manager_ops.write()
     also need to be reenterable. On the other hand,
     fpga_manager_ops.write_sg() is called once. Thus, rework usage of
     write() callback to write_sg().
  v5 -> v6: fix patch applying
     I forgot to clean up unrelated local changes which lead to error on
     patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
     applying on vanilla kernel.
  v6 -> v7: fix binding doc to pass dt_binding_check
  v7 -> v8: another fix for dt_binding_check warning
  v8 -> v9:
   * add another patch to support bitstream offset in FPGA image buffer
   * rework fpga_manager_ops.write_sg() back to fpga_manager_ops.write()
   * move image header parsing from write() to write_init()
  v9 -> v10:
   * add parse_header() callback to fpga_manager_ops
   * adjust fpga_mgr_write_init[_buf|_sg]() for parse_header() usage
   * implement parse_header() in microchip-spi driver
  v10 -> v11: include missing unaligned.h to microchip-spi
     fix error: implicit declaration of function 'get_unaligned_le[16|32]'
  v11 -> v12:
   * microchip-spi: double read hw status, ignore first read, because it
     can be unreliable.
   * microchip-spi: remove sleep between status readings in
     poll_status_not_busy() to save a few seconds. Status is polled on
     every 16 byte writes - that is quite often, therefore
     usleep_range() accumulate to a considerable number of seconds.
  v12 -> v13:
   * fpga-mgr: separate fpga_mgr_parse_header_buf() from
     fpga_mgr_write_init_buf()
   * fpga-mgr: introduce FPGA_MGR_STATE_PARSE_HEADER and
     FPGA_MGR_STATE_PARSE_HEADER_ERR fpga_mgr_states
   * fpga-mgr: rename fpga_mgr_write_init_sg() to fpga_mgr_prepare_sg()
     and rework with respect to a new fpga_mgr_parse_header_buf()
   * fpga-mgr: rework write accounting in fpga_mgr_buf_load_sg() for
     better clarity
   * microchip-spi: rename MPF_STATUS_POLL_TIMEOUT to
     MPF_STATUS_POLL_RETRIES
   * microchip-spi: add comment about status reading quirk to
     mpf_read_status()
   * microchip-spi: rename poll_status_not_busy() to mpf_poll_status()
     and add comment.
   * microchip-spi: make if statement in mpf_poll_status() easier to
     read.
  v13 -> v14:
   * fpga-mgr: improvements from Xu Yilun in
      - fpga_mgr_parse_header_buf()
      - fpga_mgr_write_init_buf()
      - fpga_mgr_prepare_sg()
      - fpga_mgr_buf_load_sg()
   * fpga-mgr: add check for -EAGAIN from fpga_mgr_parse_header_buf()
     when called from fpga_mgr_buf_load_mapped()
   * microchip-spi: remove excessive cs_change from second spi_transfer
     in mpf_read_status()
   * microchip-spi: change type of components_size_start,
     bitstream_start, i from size_t to u32 in mpf_ops_parse_header()
  v14 -> v15: eliminate memcpy() in mpf_ops_write()
    Eliminate excessive memcpy() in mpf_ops_write() by using
    spi_sync_transfer() instead of spi_write().
  v15 -> v16:
   * microchip-spi: change back components_size_start and
     bitstream_start variables types to size_t, i - to u16 in
     mpf_ops_parse_header()
   * fpga-mgr: rename fpga_parse_header_buf() to
     fpga_parse_header_mapped(). It serves only mapped FPGA image now,
     adjust it accordingly.
   * fpga-mgr: separate fpga_mgr_parse_header_sg_first() and
     fpga_mgr_parse_header_sg() from fpga_mgr_prepare_sg()
  v16 -> v17:
   * fpga-mgr: return size of allocated header from
     fpga_mgr_parse_header_sg(), add `char **ret_buf` to function args
     to save pointer to allocated header. This allow us to call
     fpga_mgr_write_init_buf() with exact size of allocated header.
   * document parse_header() callback in fpga-mgr.rst
  v17 -> v18:
   * fpga-mgr: change back fpga_mgr_parse_header_sg() to return
     allocated buffer but set buffer size into output parameter
   * fpga-mgr: check returned pointer from krealloc for ZERO_OR_NULL_PTR
     in fpga_mgr_paese_header_sg() as krealloc may return ZERO_SIZE_PTR.
   * fpga-mgr: in fpga_mgr_prepare_sg() return fpga_mgr_write_init() on
     fast path only when both initial_header_size and parse_header() are
     not defined.
   * docs: fpga-mgr: a few rewords from Xu Yilun
  v18 -> v19:
   * microchip-spi: split multiple assignments on a single line in
     functions mpf_read_status() and mpf_ops_parse_header()
   * fpga-mgr: add braces {} around "else if" arm in
     fpga_mgr_prepare_sg()
   * fpga-mgr: don't reuse krealloc() arg in fpga_mgr_parse_header_sg().
     If krealloc() returns NULL, it doesn't free the original.
  v19 -> v20:
   * fpga-mgr: initialize info->header_size with
     mops->initial_header_size at fpga_mgr_load().
   * fpga-mgr: add mops->skip_header boolean flag. Adjust skipping
     header before write to check against skip_header flag instead of
     mere presence of info->header_size.
   * fpga-mgr: split check for ZERO_OR_NULL_PTR() after realloc() in
     fpga_mgr_parse_header_sg() function to check against zero header +
     check against NULL returned from realloc().
   * docs: fpga-mgr: adjust for skip_header flag.
   * microchip-spi: add skip_header to mpf_ops.

Ivan Bornyakov (4):
  fpga: fpga-mgr: support bitstream offset in image buffer
  docs: fpga: mgr: document parse_header() callback
  fpga: microchip-spi: add Microchip MPF FPGA manager
  dt-bindings: fpga: add binding doc for microchip-spi fpga mgr

 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
 Documentation/driver-api/fpga/fpga-mgr.rst    |  27 +-
 drivers/fpga/Kconfig                          |   8 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/fpga-mgr.c                       | 236 +++++++++--
 drivers/fpga/microchip-spi.c                  | 398 ++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                 |  22 +-
 7 files changed, 703 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c

-- 
2.25.1


