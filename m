Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45E75284A
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Jul 2023 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjGMQ23 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Jul 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGMQ22 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Jul 2023 12:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCA2733
        for <linux-fpga@vger.kernel.org>; Thu, 13 Jul 2023 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A2FScgjIIHr5dgpOjhRwvmNpnwN6mlAl3MXJ/NNsJ8Q=;
        b=PM+Sy5pgn7Q8/8MQNrenkukDZmPex4tUvCfwSbpmmMq8cm9XNDLNYS/siIKhvvJ8pgsFiE
        qMzF9aEkes7t0bNcbRKINfd3bZJ+3wP3a6/fsCYPFQmhgAhjXqeT96phocSrm42UWtHLc4
        HM/Ygk90XRL0iAKpK3o3YqHcE2N7B2A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-cBgN4AUZPR-vm-Av4Xyrpw-1; Thu, 13 Jul 2023 12:27:39 -0400
X-MC-Unique: cBgN4AUZPR-vm-Av4Xyrpw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5eee6742285so8953536d6.2
        for <linux-fpga@vger.kernel.org>; Thu, 13 Jul 2023 09:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265659; x=1691857659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2FScgjIIHr5dgpOjhRwvmNpnwN6mlAl3MXJ/NNsJ8Q=;
        b=Amx+XvJxCien8NBzfqxcYe1qqcGrMVOuyih/9OtoMgbROKeeKL1weqQRGjBQmc4rg/
         uM4RTB/lc1dE7xBErp5a+x4N1g+kjiRc1ErV2twgJN4v3oy9eGBXiA//1LaRXm4b9ffL
         eO4AiBPxSCtC0WZx/YAaceiUbyfB8haOiGKMfbcHWXwatllCBJyRhoGV+DFc43X5gu4H
         q8KNfzlqvI4ibHBzVk7XKjAudIIWEWho8Pef0/gA5ek2EsZCUyUtGmDlOaY1Q6XJrNic
         zBL4AUi03tv8Zq7sMiREPQ2Rteb7hoRUM+tc1c09TIDP/fGSgbPs8VPJyA9XRHuHDeR4
         A7BA==
X-Gm-Message-State: ABy/qLbPCtTmkxHKUMf35fIBDcmcsyO1w5/iozxr+YXWplUPyvDmdX2B
        UiHvgiCUNcB/LMlhA8+KK9LrenlX1Uz8g5Hu8XWguGJ+X6fsV3XLzN/T/Ww7+N6X2i8Pc/dJRIf
        DT93TKI9MB869wO74gEtI
X-Received: by 2002:a0c:de0e:0:b0:635:eee3:e30a with SMTP id t14-20020a0cde0e000000b00635eee3e30amr1788627qvk.18.1689265659273;
        Thu, 13 Jul 2023 09:27:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTle7Z9lTdiQjHCBasxqfa24bi1jtMfyaP/Oxii3X2JU2gAQuVDGabRHcIqRGfpOQmtRJVYw==
X-Received: by 2002:a0c:de0e:0:b0:635:eee3:e30a with SMTP id t14-20020a0cde0e000000b00635eee3e30amr1788617qvk.18.1689265659051;
        Thu, 13 Jul 2023 09:27:39 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cf1d1000000b00637873ff0f3sm3206582qvl.15.2023.07.13.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:27:38 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v9 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Thu, 13 Jul 2023 18:27:27 +0200
Message-ID: <20230713162731.211669-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set introduces an initial set of KUnit test suites for the
core components of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

v9:
- Improved and commented test ops for the FPGA Manager test suite
- Fixed minor capitalization discrepancies

v8:
- Using memset to set header and payload of the test image
- Using sg_miter_* functions to check the image in the write_sg op
- Includes sorted in alphabetical order
- Add commas for fpga_bridge_ops
- Improved Makefile

v7:
- Dropped RFC prefix
- Add comments to explain fakes and helper functions
- Changed the implementation of the Bridge used in the Region suite

v6:
- Restructured the code into self-contained test modules
- Added tests for the basic behaviors of the components
- Improved programming tests for the FPGA Manager
- Fixed code/comments mismatch in the list of Bridges test case

v5:
- Removed most of the exported functions using shared buffers for stats
- Moved all KUnit expectations/assertions to the main test module
- Removed standalone use case to simplify the code
- Removed instances counters from fake components (using device.id instead)
- Set header size in the .parse_header op
- Improved bridge get_put_list test case

v4:
- Fix build error

v3:
- Calling fpga_bridges_put() between reconfigurations
- Functions for registering fake modules allocate and return context structs

v2:
- Restructured code into multiple suites to test components in isolation
- Reduced code duplication using init and exit methods
- Using a get_bridges() method to build the list of bridges just before programming
- Regions and Bridges are organized topologically
- Changed bitstream/bit to images
- Allocate images dynamically
- Renamed fpga-tests to fpga-test
- Simplified Kconfig
- Add license info to the fpga-test module

Marco Pagani (4):
  fpga: add an initial KUnit suite for the FPGA Manager
  fpga: add an initial KUnit suite for the FPGA Bridge
  fpga: add an initial KUnit suite for the FPGA Region
  fpga: add configuration for the FPGA KUnit test suites.

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 329 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 +++++++++++++++++
 8 files changed, 742 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

