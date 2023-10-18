Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935FF7CE30C
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjJRQjk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRQjj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 12:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CCAB
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697647130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oHj6EwFz8BHjW/yggtu6OM4m0PkCRoLlO9ayp66fdYs=;
        b=Fvuo2dRe6Pnh1E6AzdCNxO8DVWiqZFU3vh1T4w9P9QNvKhuZVLWT90LB2sOktczaQxyYx6
        MIpoxO+qkataLEhTp3/NE1X5ct9qtAcTDN5KQL0RAs+ClM7zVMRHY8CfSEsOMUVhrXBkzs
        YUwsLk1t4nPWBpyb9pFvjByVtaJasn8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ZdhNh5RcPgGLiQVH36mfaQ-1; Wed, 18 Oct 2023 12:38:34 -0400
X-MC-Unique: ZdhNh5RcPgGLiQVH36mfaQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d0ceb78cbso76686426d6.1
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647113; x=1698251913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHj6EwFz8BHjW/yggtu6OM4m0PkCRoLlO9ayp66fdYs=;
        b=EbAYv7YA8f+bWp/68KrcmrHxxvR7QIea/hAwEg8pUodWBAxM30nSM7vm16Bq8zfJLD
         UAJ1eukim6pAl6tFGBrRv/uFTfzEgQVzeWkpHSrgKymYuOCz2MS1yCOPslKRJdA3GE4u
         NJ1SH9zPD//gsRedqdtEnzIsemsVWwUtCdlmRrpjU/pVz0cMedG19FSmKHXGD4BEH+Rd
         4SSUMf8SduT+ohjGhdvAkYRE/RFDXNnwgvaq6DqdSvfT7JJh7ytMabiT0MUkCPhkBJNG
         9k7VVHnN7WWIBpnlua9SQ1zqyn7LPjpv6qJlYLNVAoXeheWeMxr90kgWwoa6r64f+aXz
         5Afw==
X-Gm-Message-State: AOJu0YzcsrLGj+tpiiwBG9m0RQGItKr3q1G2gPWzAhMoGc+tW7T2aKF2
        jk8oU4/qrkY8AbN6KIYt57taQFa1hEGocImnb/CTCPIkOg1QkeR3l+juJjkIG6H9+efdOXK+5YO
        wgD29Cxs5YlnIm4IWS+/g
X-Received: by 2002:ad4:5b8b:0:b0:66d:43fd:f4e4 with SMTP id 11-20020ad45b8b000000b0066d43fdf4e4mr5312163qvp.45.1697647113734;
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRD+Ge85kWm9yZdvPOOqG6RtGusTbEBje3/ErVCbJtUf+gccGOsYnKb7S21qIV56jPHTesKA==
X-Received: by 2002:ad4:5b8b:0:b0:66d:43fd:f4e4 with SMTP id 11-20020ad45b8b000000b0066d43fdf4e4mr5312147qvp.45.1697647113412;
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id mi1-20020a056214558100b0066d15724ff7sm81896qvb.52.2023.10.18.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: disable KUnit test suites when module support is enabled
Date:   Wed, 18 Oct 2023 18:38:13 +0200
Message-ID: <20231018163814.100803-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The fpga core currently assumes that all manager, bridge, and region
devices have a parent device associated with a driver that can be used
to take the module's refcount. This behavior causes the fpga test suites
to crash with a null-ptr-deref since parent fake devices do not have a
driver. This patch disables all fpga KUnit test suites when loadable
module support is enabled until the fpga core is fixed. Test suites
can still be run using the KUnit default UML kernel.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index e4a64815f16d..d4e55204c092 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
+	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem
-- 
2.41.0

