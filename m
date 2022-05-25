Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41609534422
	for <lists+linux-fpga@lfdr.de>; Wed, 25 May 2022 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiEYTQS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 25 May 2022 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbiEYTPV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 25 May 2022 15:15:21 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B648E26AD2
        for <linux-fpga@vger.kernel.org>; Wed, 25 May 2022 12:14:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 67so7203792vsh.2
        for <linux-fpga@vger.kernel.org>; Wed, 25 May 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=YhCwmzZA8IF++F4fvn5TlHJ7w6GabVuEHTUO+oxi72rZeaCOWlB+COG7eVK06i+pIA
         /rylJL/a+627OftH2zVbaUatklbClygux2am97BWOOy+7iIx3z+m2SrZQ4ej7+pCLIKX
         qi7slp2sluKpJsvO10fVCXARfCOXWAtNDjIcMZ/Nfzi1R/VF0xZOJFvNtLKn3TW5BWpw
         BW97vLJn8iE+taCwqCyaAUAx0uQSU5ig/imlBJm5RsOtHWuCLw2bTl1rkBFZCkLMC1Yi
         e1mrnF4Uf8ydSlRf3b9MwaZXL25MmtJMj9mWYdzi8I7R/R1ZG9wCJbvWEgsdb+TsV/8/
         grpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=C5CIQ0GBiFbEuRejn3MiBuj1vNGP2EvbXk1fJ7ly0Cw5scpbBIeYWmJP5q7tVD8ph4
         QCzGM7wed57Uj8Hp7e/HLUShIytDyRiB41ssB/xJMx3uWO2eT1I152ja47UqWWJ3YKQl
         EAyvrsIT7s4Qw6EIpX3DplUE9QOKq9wowumJPasY+GLt2Bdxd92eLATir2JphvJXncVR
         Z2cORwF2SCMWfv0ZDCnU5vBxRAuZ0P12YJGsxaPbRvwLlISPMHQggKQk733GAQhFOYYm
         PebnW5fuWGagdrpTXCJGy7QErCUgbVqmuUVmi4bwu93ZSRWfBhVgwrF+ojcvHmBTJKAr
         9vjg==
X-Gm-Message-State: AOAM5316qmMFpKlocLJd6cUVA+0Q1MXrz0YYISe32aXyIsDuARWYyqF7
        M4IZK+3fbCRvylrMaNa9JVtG5XDflwnQOaTEyFg=
X-Google-Smtp-Source: ABdhPJxyWu3QvaL/WDL1lvm+uKiKCgClkS9aBtpFU4ZxDf/BjKXFtN0G1z1kRMSozSHB1HAlIZ8t6JsgjeACleJBVEI=
X-Received: by 2002:a05:6102:2921:b0:337:b319:bb21 with SMTP id
 cz33-20020a056102292100b00337b319bb21mr7909452vsb.69.1653506084878; Wed, 25
 May 2022 12:14:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d484:0:b0:2bc:cae4:6d22 with HTTP; Wed, 25 May 2022
 12:14:44 -0700 (PDT)
From:   Rolf Benra <olfbenra@gmail.com>
Date:   Wed, 25 May 2022 21:14:44 +0200
Message-ID: <CA+z==Vvr9X0Z3MWZ7TtH623t5x4t2hKpvkNRXvRnoJrXF_pgRA@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Rolf Benra

olfbenra@gmail.com







----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Rolf Benra

olfbenra@gmail.com
