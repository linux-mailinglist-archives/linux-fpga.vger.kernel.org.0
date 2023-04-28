Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7A6F1A35
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbjD1OGj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjD1OGh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 10:06:37 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593A26B9;
        Fri, 28 Apr 2023 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=XkSyHWqRNF8uajfY9KastXgymoN43yvl3xT10uOHkwQ=;
        b=JG1vU3MjkrGXlPwZn6FJNNIlI8cRvnaw/SAKz2jM3qYrlageQc8qreR9/4GH6salHPBprEScItSH6
         zfxFpoRteGXY1CgENCeALzld2uAvV6PAmMxm65v11ixVnBSYmKqhbr8sWUc6h8pE9UpUMWM7uFx8Vt
         EtWs/VRMl8AiKokSyskK7bfXGJwU/fmA7EmlkzodGfAOUZzmd/cWugMHKFTIsyz7IfPEqGhV5BC6KW
         Qem06KUcWw8xFNkQMfbPgNMp5VFOzTsmjGgYlidw7bD6naCnuHbYAUxaMEMlzTGkM5oTjKGHhcewjE
         I80XRCTWBBRWJERyaT+q4V9rVzdD43g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000010,0.005175)], BW: [Enabled, t: (0.000018,0.000001)], RTDA: [Enabled, t: (0.159634), Hit: No, Details: v2.49.0; Id: 15.t7tpb.1gv42umnp.j7t; mclb], total: 0(700)
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
        Fri, 28 Apr 2023 17:05:57 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] replace Ivan Bornyakov maintainership
Date:   Fri, 28 Apr 2023 17:01:48 +0300
Message-Id: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As I'm leaving Metrotek, hand over my maintainership duties to Vladimir.

ChangeLog:
v1:
https://lore.kernel.org/lkml/20230426073519.9167-1-i.bornyakov@metrotek.ru/
v2:
  * instead of replacing my Metrotek email to a shared Metrotek System
    Team mailbox, assign Vladimir to my former maintainership.

Ivan Bornyakov (2):
  MAINTAINERS: update Microchip MPF FPGA reviewers
  dt-bindings: fpga: replace Ivan Bornyakov maintainership

 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.40.0


