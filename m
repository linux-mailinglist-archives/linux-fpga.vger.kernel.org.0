Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D3620E8E
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiKHLSm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 06:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiKHLSj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 06:18:39 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A315DFF6
        for <linux-fpga@vger.kernel.org>; Tue,  8 Nov 2022 03:18:38 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p141so11175243iod.6
        for <linux-fpga@vger.kernel.org>; Tue, 08 Nov 2022 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=IZj/YP6ZesRfJVOORnCRHdTNx230PLw1QMwGeCuUIkzl0uuo0/wao0dxTvMm3Q4ESE
         VqQlkaR0+elrZdY1r4w2XVZHzkhgtthK5OaF/HwyNK1baWy6FzLTbnkj2OwBEeRnjSbF
         MNy0BgiFIaLatL+6IpaJqbjnAzY3dnh37jk3DMpoGD8TkGsLiJdtAglXdfA7CH8a5HC0
         NkucNnNwMOn7LtDzDoZsaze9MiZFpmne7Qx9HcbmQ+ylYJ0tiyK0Wwt4QoISIMPnPRCy
         fzIPsAnsM6jO3gluisxSK2BjCUW4zjEPfOhAWEm160ScrucrO8Ho8M0EwbbbpZggClPd
         4xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=3EVf26t6qIQjEkEsLi8FfoHA6nQrK89XBlJ8vo16eGVfU6TJkM/aeUOmp8sZQ5B6+Y
         Jv5FxOtxm02Yy4soOXC4dkE3Lf7ghg028bQNPFgRduLmEwC3j6uP2MNFyzVzsVPbxaOI
         GvotN8IzA5wctK20UymxksVCNzglAtD7g8oPdGokElyHUP0rnz4xlAlvjT/72Z6K6qt6
         bLqxP7Z828s4QrWJ66ZNW6zoBK0UwPVXNJC1qul/4dLIdrohpEyyaTOoEca8s0ZIjAHF
         wocIgKxCp12vwrRwegmBlUo2EtRuIC++TFSBLJDjDE/JAAg7BTJHwa+2gs8aEzz9tcUo
         QOtw==
X-Gm-Message-State: ACrzQf0M3VoaZ9Zm7vKX4mrQWNKnQ9acrG3lmdfNwYTnA+ACz14xnL+d
        jKuOX8N+OK9fzlqoRmCunqChCxRgHwixE2gpItI=
X-Google-Smtp-Source: AMsMyM5Vs/WNPC1zsON0sIvK9PLnW5Nmmg9xW8h8XjSM0RjAGR/ePWNBNsCbV5I81jHMP3HRAvFRyjH9UU+5PJEEZUE=
X-Received: by 2002:a05:6602:13c8:b0:669:c3de:776f with SMTP id
 o8-20020a05660213c800b00669c3de776fmr31194379iov.124.1667906317661; Tue, 08
 Nov 2022 03:18:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:38a9:b0:375:4a9b:180d with HTTP; Tue, 8 Nov 2022
 03:18:37 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik1@gmail.com>
Date:   Tue, 8 Nov 2022 03:18:37 -0800
Message-ID: <CAKfr4JWDjSHVGmqJn8S4S0izNjosxkyb9=MhcnQMfOunFjs1OQ@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

-- 
Dear

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

Let me know, If you are interested for more details.....

Regards,
Andrew
