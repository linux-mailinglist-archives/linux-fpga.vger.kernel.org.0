Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32396D630D
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjDDNe1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjDDNeR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:34:17 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD223C06;
        Tue,  4 Apr 2023 06:33:55 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0DD9AE000D;
        Tue,  4 Apr 2023 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680615234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dhPKsedyNaIm395Jon3eIezMwB2v8WnHlUJJmpukY9g=;
        b=Thx8U5pQS6MGp3KVFvjDkn8adG0aYVFH99okR43UMr9h3oYL42FzBRZ/WaocJGpGLIvVUp
        Chw5l83T9ejeznKsxGtkTIuNqy3jD7FJbzBo32r7wA+vwMzJ0oJ7ePuJYeQswMhkMk7eQD
        vKujDW7RCVPNpk9k55dqoxwjjYX4J9RgnT29/R3qYm8uRCqkuolEETawgCPVIwAvM6vB1p
        PQ0LNH2X/fSIVXi7xdemSa5yjo6KXOG15DYii498tf7xDHiOBIin7EzHcqi1W0RI4rU5qL
        wgQ2Qrz/TSZ4UA92hz07Zw/U4CDvF64Loxu1rF81CBNcoFOsZGt5/fDVi61Viw==
From:   alexis.lothore@bootlin.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, nicolas.carrier@orolia.com
Subject: [PATCH 0/1] warning on FPGA bridge registration
Date:   Tue,  4 Apr 2023 15:31:01 +0200
Message-Id: <20230404133102.2837535-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Hello,
While upgrading a kernel 5.10.x to kernel 6.1.x, I observe some warnings. The
target platform is a socfpga (Cyclone V). The warning has the following trace:

[   26.725222] WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 kobject_get (./include/linux/refcount.h:199 ./include/linux/refcount.h:250 ./include/linux/refcount.h:267 ./include/linux/kref.h:45 lib/kobject.c:635)
[   26.732380] refcount_t: addition on 0; use-after-free.
[   26.737501] Modules linked in:
[   26.747935] Hardware name: Altera SOCFPGA
[   26.751939] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:255)
[   26.757175] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
[   26.762230] dump_stack_lvl from __warn (kernel/panic.c:632 kernel/panic.c:679)
[   26.767032] __warn from warn_slowpath_fmt (./include/asm-generic/preempt.h:69 ./include/linux/context_tracking.h:154 kernel/panic.c:705)
[   26.772177] warn_slowpath_fmt from kobject_get (./include/linux/refcount.h:199 ./include/linux/refcount.h:250 ./include/linux/refcount.h:267 ./include/linux/kref.h:45 lib/kobject.c:635)
[   26.777580] kobject_get from device_add (drivers/base/core.c:3760 drivers/base/core.c:3584)
[   26.782464] device_add from of_platform_device_create_pdata (drivers/of/platform.c:190)
[   26.788994] of_platform_device_create_pdata from of_platform_bus_create (drivers/of/platform.c:390)
[   26.796732] of_platform_bus_create from of_platform_populate (drivers/of/platform.c:482)
[   26.803432] of_platform_populate from fpga_bridge_register (drivers/fpga/fpga-bridge.c:365)
[   26.809967] fpga_bridge_register from alt_fpga_bridge_probe (drivers/fpga/altera-hps2fpga.c:185)
[   26.816674] alt_fpga_bridge_probe from platform_probe (drivers/base/platform.c:1401)
[   26.822682] platform_probe from really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639)
[   26.827995] really_probe from __driver_probe_device (drivers/base/dd.c:778)
[   26.833919] __driver_probe_device from driver_probe_device (drivers/base/dd.c:809)
[   26.840363] driver_probe_device from __driver_attach (drivers/base/dd.c:1195)
[   26.846460] __driver_attach from bus_for_each_dev (drivers/base/bus.c:300)
[   26.852122] bus_for_each_dev from bus_add_driver (drivers/base/bus.c:619)
[   26.857870] bus_add_driver from driver_register (drivers/base/driver.c:247)
[   26.863449] driver_register from do_one_initcall (./include/linux/jump_label.h:259 ./include/linux/jump_label.h:269 ./include/trace/events/initcall.h:48 init/main.c:1304)
[   26.869116] do_one_initcall from kernel_init_freeable (init/main.c:1375 init/main.c:1392 init/main.c:1411 init/main.c:1631)
[   26.875296] kernel_init_freeable from kernel_init (init/main.c:1521)
[   26.881047] kernel_init from ret_from_fork (arch/arm/kernel/entry-common.S:149)
[   26.886097] Exception stack(0xf0831fb0 to 0xf0831ff8)
[   26.891138] 1fa0:                                     00000000 00000000 00000000 00000000
[   26.899292] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   26.907442] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000

From my understanding, the warning occurs because the device passed to
of_platform_populate() in fpga_bridge_register() is not initialized. As a
consequence, when it will eventually try to get a reference on parent
device to create new child, it will find an uninitialized kobject and raise
the warning.

My guess is that the issue occurs since commit 0d70af3c2530 (and a revert
tends to prove it). Before this rework, device initialization and addition
were done before of_platform_populate. This commit has merged
fpga_bridge_create() and fpga_bridge_register() (and while doing so, it has
merged device_initialize() and device_add() into device_register()), but in
the meantime it has moved device_register() AFTER of_platform_populate()

A naive attempt to revert to previous behavior (device init/add before
of_platform_populate) can be found with the following patch, but since my
understanding of fpga framework is still quite limited, please let me know
if I am missing something.

Alexis Lothoré (1):
  fpga: bridge: properly initialize bridge device before populating
    children

 drivers/fpga/fpga-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.40.0

