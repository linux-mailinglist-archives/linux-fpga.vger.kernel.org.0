Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6027BC67F
	for <lists+linux-fpga@lfdr.de>; Sat,  7 Oct 2023 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjJGJoK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 7 Oct 2023 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjJGJoK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 7 Oct 2023 05:44:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C96BC
        for <linux-fpga@vger.kernel.org>; Sat,  7 Oct 2023 02:44:08 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2gJn6PNPzVlMB;
        Sat,  7 Oct 2023 17:40:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 7 Oct
 2023 17:44:05 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-fpga@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Marco Pagani <marpagan@redhat.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] fpga: Fix memory leak for fpga_region_test_class_find()
Date:   Sat, 7 Oct 2023 17:43:21 +0800
Message-ID: <20231007094321.3447084-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When CONFIG_FPGA_KUNIT_TESTS=m and making CONFIG_DEBUG_KMEMLEAK=y
and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, modprobe fpga-region-test and then
rmmod fpga-region-test, the below memory leak is detected.

fpga_region_class_find() in fpga_region_test_class_find() will call
get_device() if the data is matched, which will increment refcount for
dev->kobj, so it should call put_device() to decrement refcount for
dev->kobj to free the region, because fpga_region_unregister() will call
fpga_region_dev_release() only when the refcount for dev->kobj is zero
but fpga_region_test_init() call device_register() in
fpga_region_register_full(), which also increment refcount.

So call put_device() after calling fpga_region_class_find() in
fpga_region_test_class_find(). After applying this patch, the following
memory leak is never detected.

unreferenced object 0xffff88810c8ef000 (size 1024):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 32 bytes):
    b8 d1 fb 05 81 88 ff ff 08 f0 8e 0c 81 88 ff ff  ................
    08 f0 8e 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
    [<ffffffffa02385e1>] fpga_region_register_full+0x51/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888105fbd1b8 (size 8):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 8 bytes):
    72 65 67 69 6f 6e 30 00                          region0.
  backtrace:
    [<ffffffff817ec023>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff82995590>] kvasprintf+0xb0/0x130
    [<ffffffff83f713b1>] kobject_set_name_vargs+0x41/0x110
    [<ffffffff8304ac1b>] dev_set_name+0xab/0xe0
    [<ffffffffa02388a2>] fpga_region_register_full+0x312/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810b3b8a00 (size 256):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 8a 3b 0b 81 88 ff ff  ..........;.....
    08 8a 3b 0b 81 88 ff ff e0 ac 04 83 ff ff ff ff  ..;.............
  backtrace:
    [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
    [<ffffffff83056d7a>] device_add+0xa2a/0x15e0
    [<ffffffffa02388b1>] fpga_region_register_full+0x321/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20

Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/fpga/tests/fpga-region-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index 5ff688b394f9..7cd2667d52be 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -95,6 +95,8 @@ static void fpga_region_test_class_find(struct kunit *test)
 
 	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
 	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
+
+	put_device(&region->dev);
 }
 
 /*
-- 
2.34.1

