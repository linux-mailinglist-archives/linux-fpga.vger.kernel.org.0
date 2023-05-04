Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92EF6F6CFD
	for <lists+linux-fpga@lfdr.de>; Thu,  4 May 2023 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjEDNcz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 May 2023 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjEDNcx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 May 2023 09:32:53 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCD99;
        Thu,  4 May 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=bNgFnbd+g4Sv6e0pXoB62gBAXsqMYor9c2jjfpKvLNs=;
        b=jLHH/OP/ZbTw+soqkXA6EW/pQU4NYH3zP/Nnsh8aGA3cMQi0W8riFLK5XOCAxvIBlieXsk8gNommK
         3gR9AibKSPtM16cGhxrrjl/rFJi06D2SffSZXP/ibHkTTZj6QWxGifKLy4KYPCmlozFPhhc9IbnnrP
         eRnAaPMhNk1krz8YQQDg/FGJEjQA0rpPe46n0gCjwB0DjcFaxiCh8fDRHVXrWnOlX+mth0YsJaxKEB
         sXjAp32rSoQmeNHFBDKNzg0E0TnJ2t7Bvwgl/jMg7kq7mMJpd4fikjIen9dxb2SZvGQx2HEbKJWAYF
         nXkLCra1/PPr7dmos0bh3iQFYmLAllg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000005,0.002386)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.113823), Hit: No, Details: v2.49.0; Id: 15.d9pmw.1gvjfdbtj.1su; mclb], total: 0(700)
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
        Thu, 4 May 2023 16:32:16 +0300
From:   Vladimir Georgiev <v.georgiev@metrotek.ru>
To:     i.bornyakov@metrotek.ru
Cc:     conor.dooley@microchip.com, devicetree@vger.kernel.org,
        hao.wu@intel.com, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, robh+dt@kernel.org, system@metrotek.ru,
        trix@redhat.com, v.georgiev@metrotek.ru, yilun.xu@intel.com
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: replace Ivan Bornyakov maintainership
Date:   Thu,  4 May 2023 16:32:13 +0300
Message-Id: <20230504133213.322613-1-v.georgiev@metrotek.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230429104838.5064-3-i.bornyakov@metrotek.ru>
References: <20230429104838.5064-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>

