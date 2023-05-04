Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969516F69E7
	for <lists+linux-fpga@lfdr.de>; Thu,  4 May 2023 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjEDL1n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 May 2023 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjEDL1g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 May 2023 07:27:36 -0400
X-Greylist: delayed 1810 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 04:27:28 PDT
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22602527C;
        Thu,  4 May 2023 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=Q7IcBB6EH89RtoWFEbW8bjXq3EQN5HWyHBk5cg38oSY=;
        b=bAUKP0Tl2IF0My8qBUy5yYkGNQMKmzJpZjbKhhO2i2EuOE8unDDaxypwyffG9JxAqOEdnb/T5te97
         jh3a2vYUxTgFBduYx9exzjWtdBY9xQPCxp9knHL+YhyF+GxkptJRqT1lG+T1MqIZ0aF0n7jeHweohc
         7VBTzTooI82VZ3VNO0gDVpcifCQ7Y743ZPizLs6Rxp8cSexezalNahf9rNivffMa0hg0Vphj6HB3GT
         0VeQPhWBx16TCh8VYFu0SbZ9QCgHmnfHgIkB0YwZuB5xpH9eM5Wt8tKbRLjz0FKdZtuY6+/0Y61zG6
         tgvGj6wV5+7niEssGdtRvn85jaCif3g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000008,0.002416)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.100220), Hit: No, Details: v2.49.0; Id: 17.9x57s.1gvj4p62p.200h], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from dragon.ddg ([85.143.252.66])
        (authenticated user v.georgiev@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 4 May 2023 13:26:29 +0300
From:   Vladimir Georgiev <v.georgiev@metrotek.ru>
To:     yilun.xu@intel.com
Cc:     conor.dooley@microchip.com, devicetree@vger.kernel.org,
        hao.wu@intel.com, i.bornyakov@metrotek.ru,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        system@metrotek.ru, trix@redhat.com, v.georgiev@metrotek.ru
Subject: Re: [PATCH v3 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Date:   Thu,  4 May 2023 13:25:24 +0300
Message-Id: <20230504102524.314791-1-v.georgiev@metrotek.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZFOYQgA6TYa8hCjS@yilunxu-OptiPlex-7050>
References: <ZFOYQgA6TYa8hCjS@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu!

Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>

