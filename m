Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0452733522
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jun 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjFPPpT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jun 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbjFPPpD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 16 Jun 2023 11:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105122967
        for <linux-fpga@vger.kernel.org>; Fri, 16 Jun 2023 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686930260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+g1pX8kL0ywRot5Ot6dsLwBfrWbbWL9qZYh2h2zCWlA=;
        b=HpgroD7qzfLf+ZZ35L6ZAZ1LJnA9gUciOuLfqRmU3lEvZdCZSFO6yd1noozZIoyc9AK/SK
        yiZ0mkyMpHrNXuHyDaG5LMn22+SoZ55uXNMmSYq9eQk+MTH8YJS3JDNusk1eqxB9U0Dw5+
        RM0gSkEYmx7n+y4fhjDokcBTBsCsllU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-kEve3_ahM56zM0VOVDskcw-1; Fri, 16 Jun 2023 11:44:18 -0400
X-MC-Unique: kEve3_ahM56zM0VOVDskcw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7623ad57677so36222885a.1
        for <linux-fpga@vger.kernel.org>; Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686930258; x=1689522258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g1pX8kL0ywRot5Ot6dsLwBfrWbbWL9qZYh2h2zCWlA=;
        b=F3B/9hgIggqVtXIN+CSUDw4mY7l/qMAC7eHMZ7aGTSu2q+ge7fez8kQbh9gKR1IrQP
         vq8JbQyR/b9pmAThURl30Ebaqzv3lE8bxbONJXTdWSTCHq6/F7ZvS/UbSuyTN+9uEukg
         uYCHL5Stag7sHnGbyIchYBWAvngFoNm37N3rcAjDhTJMmiucdwnilCgFq3CmeWt9p+Tw
         qgspUPgF8lk6jZWYAkVuEjP5d4MVOveVpqph11RbO9OUq56iL3V5YzdOwxodXFHjWm7f
         xuw4oEKXntnPvLmwKvJc7p9IFyzA9YGK52s/b9IOCO0eoD9SRJcvvOa3tKDi36VbVoQm
         C1xw==
X-Gm-Message-State: AC+VfDwRxJqJuYK1V+UHuHcxgblJ/pVQ+SJ73KbsHRonApm+DB22P/wg
        0blUKEoXk7CkQYT6b+zZ4brLFg3xny4WhdDQi2inqzkJjD0tKIJuvoSVnTZcn2RDuM4FYs5BwMI
        o28JHOdm81dPQN8Xf3fiN
X-Received: by 2002:a05:620a:8d09:b0:75f:2c0:8e6b with SMTP id rb9-20020a05620a8d0900b0075f02c08e6bmr1736542qkn.43.1686930258274;
        Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50s6ldlpCd0E+qjyLKVbBXocyDiNul4FcSx4XVyapvfvYJ9Dz9zu+7AY4yjnF6XrgMoEdfng==
X-Received: by 2002:a05:620a:8d09:b0:75f:2c0:8e6b with SMTP id rb9-20020a05620a8d0900b0075f02c08e6bmr1736528qkn.43.1686930258049;
        Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b007607ecd58ecsm4436931qka.59.2023.06.16.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:44:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v7 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Fri, 16 Jun 2023 17:44:01 +0200
Message-Id: <20230616154405.220502-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set introduces an initial set of KUnit test suites for the
core components of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

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
 drivers/fpga/tests/Makefile           |   5 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 +++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 302 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++
 8 files changed, 714 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.40.1

