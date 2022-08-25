Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0295A15CD
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbiHYP3a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiHYP3G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 11:29:06 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66857B99E6;
        Thu, 25 Aug 2022 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=jzpzNoW001lI1c/jqIo38qIsNA0EE0LctYct+yyRZk4=;
        b=fCK5amHx9F1ssz6YEgqkRbkKfG1LDtS2Bkw05hMj+yZIWOTq6CDlTyZFrd2SUYxte6kltsmutNkuf
         2v4QhxHpWNQ8n2NlcENQtYvRJ/Vtftuobdvte+DQGgKSDnbrN44tPU2bndoFc/LPJ/WQQYt4fv7uXg
         ZWCUDhBLdeuj3q//uka+al8jRqR7DnEp5CmCPZWc3TnnMBXxxnqya+hs61aXl3aTm5sRLVf3FOEsOT
         V95rUfJ3hyhIRcKNzg/HCb9SMDvI6BRktTqqYHH8OWEFrtiqr12K6OuZ3IMPR1Nylfm/hzWnXy+AgU
         bEgByFRHn6APJG4cIojn6lXrZpOi2LA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000009,0.004364)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.079266), Hit: No, Details: v2.41.0; Id: 15.52k3u2.1gbappi5t.4bu; mclb], total: 0(700)
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
        Thu, 25 Aug 2022 18:26:35 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     j.zink@pengutronix.de
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        devicetree@vger.kernel.org, hao.wu@intel.com,
        kernel@pengutronix.de, linux-fpga@vger.kernel.org, mdf@kernel.org,
        robh+dt@kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Date:   Thu, 25 Aug 2022 18:25:14 +0300
Message-Id: <20220825152514.9926-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825141343.1375690-1-j.zink@pengutronix.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi, Johannes!

I just came across your patches. Surprisingly, our work interferes.

I recently posted patch-series for configuring ECP5 and was asked to make
generalized sysCONFIG driver with support for both ECP5 and MachXO2, which
I did. Sadly I don't have hardware with MachXO2, but you clearly do :)

Please, take a look at

https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/

and please help test MachXO2 variant. When we pull this off, you may add I2C
interface on top.

