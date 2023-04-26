Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56856EEFFF
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Apr 2023 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbjDZIKa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Apr 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbjDZIKY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Apr 2023 04:10:24 -0400
X-Greylist: delayed 1815 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 01:10:09 PDT
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8B469A;
        Wed, 26 Apr 2023 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=4rlklj+GZjW3ZmiWVg+7CcDR1nILhtblvzOvwIoHUqo=;
        b=JlL9bB5xXB6B/UXQ7DZa897YN2IhG0VU+UMiyVqLo+AlCn1IONpxlkL8HMW2DDN5ihYELGjd+vHWD
         Ymv8ciyN4jiF5DUiisR1ZUk1gi4HcerzKKRoAAeeNveHt21hEj4F2I0r4MNOhJKhBoZfced59Tlbdg
         hdVcZLoA0t4v6OD7aP/UbF7XZ6IVo+kHUBGruKyNtkZ3SMGBMCfRcER2ijFVLg911gAsq76uDgPsD7
         v77/iW2MCK0HOYi5j23fyuF6c5oCt6zFrHqKQMVDuYAPoxZED0EskJzj010T7kfcloTLrOs7FZc7nn
         fAktB5iE1bftWLYZ9wMq1sfN9Nc/xRA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000010,0.004590)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.093704), Hit: No, Details: v2.49.0; Id: 15.rkk6v.1guu81hhb.2rj; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 26 Apr 2023 10:39:27 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] replace Ivan Bornyakov maintainership
Date:   Wed, 26 Apr 2023 10:35:17 +0300
Message-Id: <20230426073519.9167-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As I'm leaving Metrotek and my Metrotek email will be off soon, replace
it with Metrotek System Team collective inbox everywhere I was engaged
in maintainership.

Ivan Bornyakov (2):
  MAINTAINERS: update Microchip MPF FPGA reviewers
  dt-bindings: fpga: replace Ivan Bornyakov maintainership

 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.40.0


