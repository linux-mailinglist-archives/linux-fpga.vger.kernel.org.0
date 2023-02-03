Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D909A689FFD
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Feb 2023 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjBCRIO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Feb 2023 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjBCRIL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Feb 2023 12:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718EB9D07C
        for <linux-fpga@vger.kernel.org>; Fri,  3 Feb 2023 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P+vuSKEpv7Ptnqb54aBjdlAa8wCTiq9HDLYMTKqctAU=;
        b=hhgLKwjIlTH991dRMjDOmF9GxNYqhYmp8IbypWGmu2HfHccparUGoVHJkF0geCE93CfojQ
        du3G1ZD/boTRcLsKxyitjp74z8diy4kc7CBf4k+Au7PpT28ePrqUt1WWNLThU9XsPAyq6N
        jsae0XE6TIdziTii8QCGf3Cm+o+dKHU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-QkDOJvVpMl23YjIOwFPjWQ-1; Fri, 03 Feb 2023 12:07:15 -0500
X-MC-Unique: QkDOJvVpMl23YjIOwFPjWQ-1
Received: by mail-qt1-f199.google.com with SMTP id a13-20020ac8108d000000b003b7ea9814a2so2915393qtj.2
        for <linux-fpga@vger.kernel.org>; Fri, 03 Feb 2023 09:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+vuSKEpv7Ptnqb54aBjdlAa8wCTiq9HDLYMTKqctAU=;
        b=set3e1R7K9V699rWLDXm4u7L2t5M2cJeqXDyPJtfRqKyxXJ/sg5aosmPjF7ugbFhAe
         uzwYrPd5WDLQDynwcuJCIS9A/oSFWo/anv1DCIWPPqEuNr8Q2DrlKguCgieQegWg9pya
         0znfJGzRXfrIghGPzCqtYGus/q3+7+p4K9VyHYYkUV5bam9ybxUlCOfVEN4W/mQ3Vvtp
         IBj+K+wl4ohCWhQEt5iluDmp36kZ+AamlsacY4i3Y2IzKxOccLXqyQJW6/uzFbbM0dKY
         N0tsoFRerQS/tPrSG5zkTuznk08KtlBUsgWvwmyA5zZmjPt0oLv8ADUvRI9ecU7H/DNP
         8G/A==
X-Gm-Message-State: AO0yUKXANBZh28Jh69V0+JjkNzhoIcusvBgrnALsx5HiLXp+lM53bZNu
        dSCW4Ds+SN3cuz1D2Beg2+gyV3uSZ3/cbpDPgRzSWplscZZQ0QnhJ1iEWiwbSFIobbPZ3UGNxnd
        ANws4Iq6KVf9K8y365YZm
X-Received: by 2002:a05:622a:10c:b0:3b8:5c86:37ea with SMTP id u12-20020a05622a010c00b003b85c8637eamr20570117qtw.61.1675444034633;
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+kH4s2nd8RhLz2fKDsH8hHgdZOlZ8qWJ/WU2eD0T5Of2sUyULk312vzsiW/h/v7QBn28adWw==
X-Received: by 2002:a05:622a:10c:b0:3b8:5c86:37ea with SMTP id u12-20020a05622a010c00b003b85c8637eamr20570093qtw.61.1675444034444;
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/4] fpga: add initial KUnit test suite for the subsystem
Date:   Fri,  3 Feb 2023 18:06:49 +0100
Message-Id: <20230203170653.414990-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set introduces a KUnit suite to test the core components
of the FPGA subsystem. More specifically, the suite tests the core
functions of the FPGA manager, FPGA bridge, and FPGA region.

These components are tested using "fake" modules that allow
observing their internals without altering the source code.

The test suite can be run using
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

Marco Pagani (4):
  fpga: add initial KUnit test suite
  fpga: add fake FPGA region
  fpga: add fake FPGA manager
  fpga: add fake FPGA bridge

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  15 ++
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fake-fpga-bridge.c | 214 +++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 +++
 drivers/fpga/tests/fake-fpga-mgr.c    | 365 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h    |  42 +++
 drivers/fpga/tests/fake-fpga-region.c | 186 +++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  37 +++
 drivers/fpga/tests/fpga-tests.c       | 264 +++++++++++++++++++
 12 files changed, 1175 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h
 create mode 100644 drivers/fpga/tests/fpga-tests.c

-- 
2.39.1

