Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A219F7E171A
	for <lists+linux-fpga@lfdr.de>; Sun,  5 Nov 2023 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjKEWAJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 5 Nov 2023 17:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjKEWAI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 5 Nov 2023 17:00:08 -0500
X-Greylist: delayed 5190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:00:05 PST
Received: from SMTP-HCRC-200.brggroup.vn (mail.hcrc.vn [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A6DD;
        Sun,  5 Nov 2023 14:00:05 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 1B799192D5;
        Mon,  6 Nov 2023 01:57:58 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 15098194B1;
        Mon,  6 Nov 2023 01:57:58 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id A0B2B1B82534;
        Mon,  6 Nov 2023 01:57:59 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0ygaSZLTPv_7; Mon,  6 Nov 2023 01:57:59 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 6E7191B8253C;
        Mon,  6 Nov 2023 01:57:59 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 6E7191B8253C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210679;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=HsFTSHSymMdSDnjBo2fw7z4oHl2AAmr5LvrFblqbzsrLI0kMd2RRsR3BWHsqN1wUr
         sxKBMU6xUOktWaYnPi9u+GQ9oNuAB0UaZQSLqcwvwep3HsXsdELqbovCbl2leGbTmF
         W0ySTV8+YIy82DLvy6+0XRCWDAPzdtjrZc46FFldJxu2f5BYMfkRCVpqT2ifJVD9eF
         NOk9SotFFraobc/+/tX4vivM2l67embfsYMfAvLJLb3i0Y+lPo55k1K30wuhRlhFFg
         KivPVknlB+bH9s7ifS/dfxNevDxRF7fkN+XS87wXIvcN+UFqOfyeDHpR8masmHYqXG
         cCXnR6xGHFZ8A==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gwi5rceU86aA; Mon,  6 Nov 2023 01:57:59 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 1C6031B8203A;
        Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:38 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185753.1C6031B8203A@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

