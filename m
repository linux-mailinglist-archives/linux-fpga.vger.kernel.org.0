Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0576B4E05
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Mar 2023 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCJRHE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Mar 2023 12:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCJRGn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Mar 2023 12:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5950112D4B0
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678467863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntnBmg9Y13vMCr/NPjoeR/EgE7m2ob3BUMK5F56zY8I=;
        b=FIH7ib4isChlUpOF8Vad19UIVYNIxaYjLcFIFHMjCyTeQxcApxy/x7Dtrr+IFUb0XWYMCw
        4th1NyZyX8e4zEhx1FlqD1IwZydGNjQi/32nThxGi19Vn31wUI71kPwBCj0XDqdcn63FCd
        w8g/lh/cq4gMLS7TlsIA4+Nkc/rs+j0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-iAvXEzyaPuqgCG1Ru8uagg-1; Fri, 10 Mar 2023 12:04:19 -0500
X-MC-Unique: iAvXEzyaPuqgCG1Ru8uagg-1
Received: by mail-wm1-f70.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so2222240wme.2
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntnBmg9Y13vMCr/NPjoeR/EgE7m2ob3BUMK5F56zY8I=;
        b=XY0YXgJyCZ20wX8JeI6EW5LOmVHXf5WnDYvUQGUCjqPAOjW4XSabazOqQRhg/76pUP
         wMH3oGPRlLl2YspN8lxJ2LFbqk9EtzXY/iTsuQoa8mYhY4BTmRWmtZD3+OQbG/GF9Tyu
         8vH8Sy4nSLxfHrW5jEww/41G99Stl8UD/9kByV2pOlMdV3XgZkYKYqQqBu7RdXkRzjNg
         Bh9tSXGjboAQtAQOElrPZt+kbQwYAsODFb/4ZM7SfbdrEFu2n2Q+hd0dxiTZ7Fs53Sxx
         Ivd+B1CToMSgxlmolom0gjlysnF8rT0vPNTfnBbOeLCkV4VaM49TU5bPk4pYg4B/voB3
         JVvg==
X-Gm-Message-State: AO0yUKUi2HXFZCLzqu1LpszmlfdmGPMtNaMJa95Hjc8cujag3ez0hNwG
        F4WsCDFGkn70gxUaQvsxdqbpvj4OzU+qZA2PfdgS2airq0OhoA562Fdr24KjwG23ga8TuOsbU4v
        JopSWwSDaMmEbIasM7HSD
X-Received: by 2002:a05:600c:3ba6:b0:3eb:29fe:7bad with SMTP id n38-20020a05600c3ba600b003eb29fe7badmr3670295wms.1.1678467857956;
        Fri, 10 Mar 2023 09:04:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8uIfWRvvy/bCp8H9VF8JVNmPIdx33QTCNbtLsT3W/XIO/IfIVvijdV7/D3I7pD+vTCILnemw==
X-Received: by 2002:a05:600c:3ba6:b0:3eb:29fe:7bad with SMTP id n38-20020a05600c3ba600b003eb29fe7badmr3670261wms.1.1678467857626;
        Fri, 10 Mar 2023 09:04:17 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003eb192787bfsm417294wmm.25.2023.03.10.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:04:17 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Fri, 10 Mar 2023 18:04:08 +0100
Message-Id: <20230310170412.708363-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set introduces initial KUnit test suites for the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

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
  fpga: add fake FPGA manager
  fpga: add fake FPGA bridge
  fpga: add fake FPGA region
  fpga: add initial KUnit test suites

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fake-fpga-bridge.c | 228 ++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 ++
 drivers/fpga/tests/fake-fpga-mgr.c    | 369 +++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h    |  42 +++
 drivers/fpga/tests/fake-fpga-region.c | 219 +++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  38 ++
 drivers/fpga/tests/fpga-test.c        | 501 ++++++++++++++++++++++++++
 12 files changed, 1460 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h
 create mode 100644 drivers/fpga/tests/fpga-test.c

-- 
2.39.2

